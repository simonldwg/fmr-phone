import '../../exercise/domain/models/exercise.dart';
import '../../exercise/domain/models/exercise_intensity.dart';
import '../../library/domain/models/song.dart';
import '../../recommendation/domain/models/recommendation.dart';
import '../../recommendation/domain/models/recommendation_params.dart';
import '../../settings/domain/models/fmr_settings.dart';
import 'models/exercise_log.dart';
import 'models/exercise_log_event.dart';

class ExerciseLogger {
  ExerciseLog? _current;
  ExerciseLog? _lastCompleted;

  ExerciseLog? get lastCompletedLog => _lastCompleted;

  void start({required FMRSettings settings, required Exercise exercise}) {
    _current = ExerciseLog.from(settings: settings, exercise: exercise);
  }

  void cancel() => _current = null;

  ExerciseLog? finish() {
    final log = _current;
    if (log == null) return null;
    _closeOpenInterval(log, DateTime.now());
    log.endTime = DateTime.now();
    _current = null;
    _lastCompleted = log;
    return log;
  }

  void logIntervalTransition({
    required ExerciseIntensity intensity,
    required Duration plannedDuration,
  }) {
    final log = _current;
    if (log is! IntervalExerciseLog) return;
    final now = DateTime.now();
    _closeOpenInterval(log, now);
    log.intervals.add(
      IntervalLogEntry(
        intensity: intensity,
        plannedDuration: plannedDuration,
        actualStartTime: now,
      ),
    );
  }

  void _closeOpenInterval(ExerciseLog log, DateTime now) {
    if (log is! IntervalExerciseLog || log.intervals.isEmpty) return;
    final last = log.intervals.last;
    if (last.actualEndTime == null) {
      log.intervals[log.intervals.length - 1] = last.copyWith(
        actualEndTime: now,
      );
    }
  }

  void logHeartRate(int bpm) =>
      _add(HeartRateLogEvent(timestamp: DateTime.now(), bpm: bpm));

  void logStepsPerMinute(int steps) =>
      _add(StepsPerMinuteLogEvent(timestamp: DateTime.now(), steps: steps));

  void logStepsPerMinuteStats({
    required int min,
    required int max,
    required int average,
    required DateTime startTime,
    required DateTime endTime,
  }) => _add(
    StepsPerMinuteStatsLogEvent(
      timestamp: DateTime.now(),
      min: min,
      max: max,
      average: average,
      startTime: startTime,
      endTime: endTime,
    ),
  );

  void logRunningStepsTotal(int steps) =>
      _add(RunningStepsTotalLogEvent(timestamp: DateTime.now(), steps: steps));

  void logSongChanged({
    required Song? previousSong,
    required Song nextSong,
    required Duration playedDuration,
    bool userSkip = false,
    RecommendationParams? requestParams,
    Recommendation? recommendation,
  }) => _add(
    SongChangedLogEvent(
      timestamp: DateTime.now(),
      previousSong: previousSong,
      nextSong: nextSong,
      playedDuration: playedDuration,
      userSkip: userSkip,
      requestParams: requestParams,
      recommendation: recommendation,
    ),
  );

  void _add(ExerciseLogEvent event) => _current?.events.add(event);
}
