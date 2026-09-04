import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../exercise/domain/models/exercise.dart';
import '../../../exercise/domain/models/exercise_intensity.dart';
import '../../../settings/domain/models/fmr_settings.dart';
import 'exercise_log_event.dart';

part 'exercise_log.g.dart';

sealed class ExerciseLog {
  ExerciseLog({required this.settings, required this.startTime});
  final FMRSettings settings;
  final DateTime startTime;
  DateTime? endTime;
  final List<ExerciseLogEvent> events = [];

  factory ExerciseLog.from({
    required FMRSettings settings,
    required Exercise exercise,
  }) => switch (exercise) {
    ContinuousExercise(:final intensity) => ContinuousExerciseLog(
      settings: settings,
      startTime: exercise.startTime,
      intensity: intensity,
    ),
    IntervalExercise(:final intervals) =>
      IntervalExerciseLog(settings: settings, startTime: exercise.startTime)
        ..intervals.add(
          IntervalLogEntry(
            intensity: intervals.first.intensity,
            plannedDuration: intervals.first.duration,
            actualStartTime: exercise.startTime,
          ),
        ),
  };

  Map<String, dynamic> toJson();

  // Necessary because endTime and events are dynamically filled during the
  // lifetime of the log object. However, json_serializable does not well with
  // inheritance and dynamically filled fields (see
  // https://github.com/google/json_serializable.dart/issues/749).
  Map<String, dynamic> get _baseFields => {
    'endTime': endTime?.toIso8601String(),
    'events': events.map((e) => e.toJson()).toList(),
  };
}

@JsonSerializable(explicitToJson: true)
class ContinuousExerciseLog extends ExerciseLog {
  ContinuousExerciseLog({
    required super.settings,
    required super.startTime,
    required this.intensity,
  });
  final ExerciseIntensity intensity;
  @override
  Map<String, dynamic> toJson() => {
    'type': 'continuous',
    ..._$ContinuousExerciseLogToJson(this),
    ..._baseFields,
  };
}

@JsonSerializable(explicitToJson: true)
class IntervalExerciseLog extends ExerciseLog {
  IntervalExerciseLog({required super.settings, required super.startTime})
      : intervals = [];
  final List<IntervalLogEntry> intervals;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'interval',
    ..._$IntervalExerciseLogToJson(this),
    ..._baseFields,
    'intervals': intervals.map((e) => e.toJson()).toList(),
  };
}

@CopyWith()
@JsonSerializable(includeIfNull: false)
class IntervalLogEntry {
  const IntervalLogEntry({
    required this.intensity,
    required this.plannedDuration,
    required this.actualStartTime,
    this.actualEndTime,
  });
  final ExerciseIntensity intensity;
  @DurationSecondsConverter()
  final Duration plannedDuration;
  final DateTime actualStartTime;
  final DateTime? actualEndTime;

  Map<String, dynamic> toJson() => _$IntervalLogEntryToJson(this);
}
