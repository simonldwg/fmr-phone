import 'dart:math';

import 'exercise_log.dart';
import 'exercise_log_event.dart';

enum ExerciseLogType { continuous, interval }

class ExerciseLogSummary {
  const ExerciseLogSummary({
    required this.type,
    required this.duration,
    required this.avgHeartRate,
    required this.minHeartRate,
    required this.maxHeartRate,
    required this.totalSteps,
    required this.avgStepsPerMinute,
    required this.minStepsPerMinute,
    required this.maxStepsPerMinute,
  });

  final ExerciseLogType type;
  final Duration duration;
  final int? avgHeartRate;
  final int? minHeartRate;
  final int? maxHeartRate;
  final int? totalSteps;
  final int? avgStepsPerMinute;
  final int? minStepsPerMinute;
  final int? maxStepsPerMinute;

  factory ExerciseLogSummary.from(ExerciseLog log) {
    final heartRates = log.events
        .whereType<HeartRateLogEvent>()
        .map((e) => e.bpm)
        .toList();
    final stepsStats = log.events
        .whereType<StepsPerMinuteStatsLogEvent>()
        .toList();
    final totalStepsEvents = log.events
        .whereType<RunningStepsTotalLogEvent>()
        .toList();

    return ExerciseLogSummary(
      type: switch (log) {
        ContinuousExerciseLog() => ExerciseLogType.continuous,
        IntervalExerciseLog() => ExerciseLogType.interval,
      },
      duration: (log.endTime ?? DateTime.now()).difference(log.startTime),
      avgHeartRate: _average(heartRates),
      minHeartRate: heartRates.isEmpty ? null : heartRates.reduce(min),
      maxHeartRate: heartRates.isEmpty ? null : heartRates.reduce(max),
      totalSteps: totalStepsEvents.isEmpty
          ? null
          : totalStepsEvents
                .reduce((a, b) => a.timestamp.isAfter(b.timestamp) ? a : b)
                .steps,
      avgStepsPerMinute: _average(stepsStats.map((e) => e.average).toList()),
      minStepsPerMinute: stepsStats.isEmpty
          ? null
          : stepsStats.map((e) => e.min).reduce(min),
      maxStepsPerMinute: stepsStats.isEmpty
          ? null
          : stepsStats.map((e) => e.max).reduce(max),
    );
  }

  static int? _average(List<int> values) {
    if (values.isEmpty) return null;
    return (values.reduce((a, b) => a + b) / values.length).round();
  }
}
