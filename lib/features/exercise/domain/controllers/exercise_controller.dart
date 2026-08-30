import 'dart:async';
import 'package:fitness_music_recommender/features/exercise/domain/controllers/exercise_exception.dart';
import 'package:fitness_music_recommender/features/playback/playback_providers.dart';
import 'package:fitness_music_recommender/features/wear/data/wear_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../library/domain/models/song.dart';
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
    await _prepareAndStartPlayback(intensity);
    if (!state.isStarting) return;

    state = state.copyWith(
      exercise: ContinuousExercise(
        intensity: intensity,
        startTime: DateTime.now(),
      ),
    );
  }

  Future<void> startInterval(List<Interval> intervals) async {
    await _prepareAndStartPlayback(intervals.first.intensity);
    if (!state.isStarting) return;

    final exercise = IntervalExercise(
      intervals: intervals,
      startTime: DateTime.now(),
    );
    state = state.copyWith(exercise: exercise);
    _scheduleNextIntervalTransition(exercise);
  }

  Future<void> _prepareAndStartPlayback(
    ExerciseIntensity firstIntensity,
  ) async {
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
      disablePowerOptimization: settings.disablePowerOptimization
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

    // start playback
    final playbackController = ref.read(exercisePlaybackProvider);
    await playbackController.startWithIntensity(
      exerciseIntensity: firstIntensity,
      getCurrentHeartRate: () => state.latestHeartRate ?? initialHr,
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

      final newIntensity = exercise.currentInterval(DateTime.now())?.intensity;
      if (newIntensity != null) {
        await ref
            .read(exercisePlaybackProvider)
            .updateTargetIntensity(newIntensity);
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

    switch (message) {
      case HeartRateMessage(:final bpm):
        state = state.copyWith(latestHeartRate: bpm);
      case NextSongMessage():
        playbackController.next();
      case PlayPauseMessage():
        playbackController.togglePlayPause();
      case StopExerciseMessage():
      case ExerciseStoppedMessage():
        stop();
      default:
        break;
    }
  }

  Future<void> stop() async {
    _intervalTimer?.cancel();
    _intervalTimer = null;
    await _cancelSubscriptions();

    await ref.read(exercisePlaybackProvider).stop();
    await ref.read(wearRepositoryProvider).sendStopExerciseMessage();

    state = const ExerciseState.idle();
  }
}
