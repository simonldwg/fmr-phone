import 'exercise_intensity.dart';
import 'interval.dart';

sealed class Exercise {
  const Exercise({required this.startTime});
  final DateTime startTime;
  ExerciseIntensity get currentIntensity;
}

final class ContinuousExercise extends Exercise {
  final ExerciseIntensity intensity;

  const ContinuousExercise({required this.intensity, required super.startTime});

  @override
  ExerciseIntensity get currentIntensity => intensity;

  ContinuousExercise withIntensity(ExerciseIntensity intensity) =>
      ContinuousExercise(intensity: intensity, startTime: startTime);
}

final class IntervalExercise extends Exercise {
  final List<Interval> intervals;

  IntervalExercise({
    required List<Interval> intervals,
    required super.startTime,
  }) : intervals = List.unmodifiable(intervals),
       assert(
         intervals.isNotEmpty,
         'IntervalExercise requires at least one Interval',
       );

  late final List<Duration> _cumulativeIntervalEnds = _computeCumulativeEnds();

  List<Duration> _computeCumulativeEnds() {
    var total = Duration.zero;
    return [for (final i in intervals) total += i.duration];
  }

  Duration get totalDuration => _cumulativeIntervalEnds.last;

  int? currentIntervalIndexAt(DateTime now) {
    final timeSinceStart = now.difference(startTime);
    if (timeSinceStart.isNegative || timeSinceStart >= totalDuration) {
      return null;
    }
    for (var i = 0; i < _cumulativeIntervalEnds.length; i++) {
      // We start going through the list. If the time since starting the
      // exercise is less than the end of the interval (i.e. the end of the
      // interval has not happened yet), we return the index i.
      // Because we start at the beginning of the interval list, this condition
      // will first evaluate to true at the current interval, since it is the
      // first interval in the list that has not ended.
      if (timeSinceStart < _cumulativeIntervalEnds[i]) return i;
    }
    return null;
  }

  Interval? currentInterval(DateTime now) {
    final index = currentIntervalIndexAt(now);
    return index == null ? null : intervals[index];
  }

  /// Returns the time where the next transition will happen (i.e. a transition
  /// to the next interval or the end of the exercise). Returns null if the
  /// exercise has already ended.
  DateTime? nextTransitionAt(DateTime now) {
    final index = currentIntervalIndexAt(now);
    if (index == null) return null;
    return startTime.add(_cumulativeIntervalEnds[index]);
  }

  /// Returns the next interval. Returns null if there is no next interval, i.e.
  /// if the exercise will end or has already ended.
  Interval? getNextInterval(DateTime now) {
    final index = currentIntervalIndexAt(now);
    if (index == null || index + 1 >= intervals.length) return null;
    return intervals[index + 1];
  }

  @override
  ExerciseIntensity get currentIntensity {
    final now = DateTime.now();
    return currentInterval(now)?.intensity ?? intervals.last.intensity;
  }
}
