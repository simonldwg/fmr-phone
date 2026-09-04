import 'dart:async';
import 'package:fitness_music_recommender/features/exercise/domain/controllers/exercise_exception.dart';
import 'package:fitness_music_recommender/features/playback/playback_providers.dart';
import 'package:fitness_music_recommender/features/wear/data/wear_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../library/domain/models/song.dart';
import '../../../logging/logging_providers.dart';
import '../../../settings/data/settings_controller_provider.dart';
import '../../../wear/domain/models/wear_message.dart';
import '../../../wear/wear_providers.dart';
import '../models/exercise.dart';
import '../models/exercise_intensity.dart';
import '../models/exercise_state.dart';
import '../models/interval.dart';

class ExerciseController extends Notifier<ExerciseState> {
  StreamSubscription<WearMessage>? _wearSub;
  ProviderSubscription<Song?>? _songListener;
  Timer? _intervalTimer;

  @override
  ExerciseState build() {
    ref.onDispose(() => _wearSub?.cancel());
    return const ExerciseState.idle();
  }

  Future<void> startContinuous(ExerciseIntensity intensity) async {
    await _prepareExercise();
    if (!state.isStarting) return;

    final exercise = ContinuousExercise(
      intensity: intensity,
      startTime: DateTime.now(),
    );

    // set up logging
    _setupLogging(exercise);

    // update state
    state = state.copyWith(exercise: exercise);

    await _startPlayback(intensity);
  }

  Future<void> startInterval(List<Interval> intervals) async {
    await _prepareExercise();
    if (!state.isStarting) return;

    final exercise = IntervalExercise(
      intervals: intervals,
      startTime: DateTime.now(),
    );

    // set up logging
    _setupLogging(exercise);

    // update state
    state = state.copyWith(exercise: exercise);

    _scheduleNextIntervalTransition(exercise);
    await _startPlayback(intervals.first.intensity);
  }

  void _setupLogging(Exercise exercise) {
    final logger = ref.read(exerciseLoggerProvider);
    final settings = ref.read(settingsControllerProvider).requireSettings;
    logger.start(settings: settings, exercise: exercise);
  }

  Future<void> _prepareExercise() async {
    final settings = ref.read(settingsControllerProvider).requireSettings;
    final wear = ref.read(wearRepositoryProvider);

    state = const ExerciseState.starting();

    // subscribe to messages received from the watch
    _wearSub = wear.messages.listen(_onWearMessage);
    // subscribe to song changes in order to send song updates to the watch
    _subscribeToSongUpdates(wear);

    // This is used to wait for the first heart rate value received from the
    // watch. While the first heart rate is not necessary for recommending the
    // first song, it signals that the exercise has started correctly on the
    // watch.
    final firstHeartRate = Completer<int>();
    final firstHrSub = wear.messages.whereType<HeartRateMessage>().listen((m) {
      if (!firstHeartRate.isCompleted) firstHeartRate.complete(m.bpm);
    });

    await wear.sendStartExerciseMessage(
      useBasicExerciseScreen: settings.useBasicExerciseScreen,
      disablePowerOptimization: settings.disablePowerOptimization,
    );

    // try waiting for the first heart rate value
    final int initialHr;
    try {
      initialHr = await firstHeartRate.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw ExerciseException(
          'Heart rate value was not received within 30s',
        ),
      );
    } catch (e) {
      await _cancelSubscriptions();
      state = const ExerciseState.idle();
      rethrow;
    } finally {
      // always cancel the now unnecessary subscription for receiving the first
      // heart rate
      await firstHrSub.cancel();
    }

    // If stop has been called while waiting during the code above, return
    if (!state.isStarting) return;

    state = state.copyWith(latestHeartRate: initialHr);
  }

  Future<void> _startPlayback(ExerciseIntensity firstIntensity) async {
    final playbackController = ref.read(exercisePlaybackProvider);
    await playbackController.startWithIntensity(
      exerciseIntensity: firstIntensity,
      getCurrentHeartRate: () => state.latestHeartRate!,
    );
  }

  void _scheduleNextIntervalTransition(IntervalExercise exercise) {
    final now = DateTime.now();
    final nextTransition = exercise.nextTransitionAt(now);

    // If nextTransition is null, we know that the exercise has ended.
    if (nextTransition == null) {
      stop();
      return;
    }

    _intervalTimer?.cancel();
    _intervalTimer = Timer(nextTransition.difference(now), () async {
      if (!state.isRunning) return;

      final newInterval = exercise.currentInterval(DateTime.now());
      if (newInterval != null) {
        ref.read(exerciseLoggerProvider).logIntervalTransition(
          intensity: newInterval.intensity,
          plannedDuration: newInterval.duration,
        );
        await ref
            .read(exercisePlaybackProvider)
            .updateTargetIntensity(newInterval.intensity);
      }

      // force rebuild to update the UI
      state = state.copyWith();

      _scheduleNextIntervalTransition(exercise);
    });
  }

  Future<void> changeIntensity(ExerciseIntensity intensity) async {
    final current = state.exercise;
    if (current == null) return;
    if (current is! ContinuousExercise) {
      throw ExerciseException(
        'Altering the intensity directly is only allowed for ContinuousExercises',
      );
    }
    state = state.copyWith(exercise: current.withIntensity(intensity));
    await ref.read(exercisePlaybackProvider).updateTargetIntensity(intensity);
  }

  Future<void> cycleIntensity() async {
    final current = state.exercise;
    if (current == null) return;
    if (current is! ContinuousExercise) {
      throw ExerciseException(
        'Altering the intensity directly is only allowed for ContinuousExercises',
      );
    }
    final values = ExerciseIntensity.values;
    final nextIndex = (values.indexOf(current.intensity) + 1) % values.length;
    await changeIntensity(values[nextIndex]);
  }

  void _subscribeToSongUpdates(WearRepository wear) {
    _songListener = ref.listen(currentSongProvider, (previous, song) {
      if (song != null) {
        wear.sendCurrentSong(song);
      }
    });
  }

  Future<void> _cancelSubscriptions() async {
    await _wearSub?.cancel();
    _wearSub = null;
    _songListener?.close();
    _songListener = null;
  }

  void _onWearMessage(WearMessage message) {
    final playbackController = ref.read(exercisePlaybackProvider);
    final logger = ref.read(exerciseLoggerProvider);

    switch (message) {
      case HeartRateMessage(:final bpm):
        state = state.copyWith(latestHeartRate: bpm);
        logger.logHeartRate(bpm);
      case StepsPerMinuteMessage(:final steps):
        logger.logStepsPerMinute(steps);
      case StepsPerMinuteStatsMessage(
        :final min,
        :final max,
        :final average,
        :final startTime,
        :final endTime,
      ):
        logger.logStepsPerMinuteStats(
          min: min,
          max: max,
          average: average,
          startTime: startTime,
          endTime: endTime,
        );
      case RunningStepsTotalMessage(:final steps):
        logger.logRunningStepsTotal(steps);
      case NextSongMessage():
        playbackController.next();
      case PlayPauseMessage():
        playbackController.togglePlayPause();
      case StopExerciseMessage():
        stop();
      default:
        break;
    }
  }

  Future<void> stop() async {
    final wear = ref.read(wearRepositoryProvider);

    _intervalTimer?.cancel();
    _intervalTimer = null;

    await ref.read(exercisePlaybackProvider).stop();
    await ref.read(wearRepositoryProvider).sendStopExerciseMessage();

    // wait for the watch to tell us that it has stopped the exercise too
    final exerciseStopped = Completer<void>();
    final exerciseStoppedSub = wear.messages
        .whereType<ExerciseStoppedMessage>()
        .listen((m) {
          if (!exerciseStopped.isCompleted) exerciseStopped.complete();
        });

    try {
      await exerciseStopped.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw ExerciseException(
          'ExerciseStopped message was not received from the watch within 30s',
        ),
      );
    } finally {
      await _cancelSubscriptions();
      ref.read(exerciseLoggerProvider).finish();
      state = const ExerciseState.idle();
      await exerciseStoppedSub.cancel();
    }
  }
}
