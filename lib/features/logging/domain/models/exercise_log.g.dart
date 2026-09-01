// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_log.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IntervalLogEntryCWProxy {
  IntervalLogEntry intensity(ExerciseIntensity intensity);

  IntervalLogEntry plannedDuration(Duration plannedDuration);

  IntervalLogEntry actualStartTime(DateTime actualStartTime);

  IntervalLogEntry actualEndTime(DateTime? actualEndTime);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IntervalLogEntry(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IntervalLogEntry(...).copyWith(id: 12, name: "My name")
  /// ```
  IntervalLogEntry call({
    ExerciseIntensity intensity,
    Duration plannedDuration,
    DateTime actualStartTime,
    DateTime? actualEndTime,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfIntervalLogEntry.copyWith(...)` or call `instanceOfIntervalLogEntry.copyWith.fieldName(value)` for a single field.
class _$IntervalLogEntryCWProxyImpl implements _$IntervalLogEntryCWProxy {
  const _$IntervalLogEntryCWProxyImpl(this._value);

  final IntervalLogEntry _value;

  @override
  IntervalLogEntry intensity(ExerciseIntensity intensity) =>
      call(intensity: intensity);

  @override
  IntervalLogEntry plannedDuration(Duration plannedDuration) =>
      call(plannedDuration: plannedDuration);

  @override
  IntervalLogEntry actualStartTime(DateTime actualStartTime) =>
      call(actualStartTime: actualStartTime);

  @override
  IntervalLogEntry actualEndTime(DateTime? actualEndTime) =>
      call(actualEndTime: actualEndTime);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `IntervalLogEntry(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// IntervalLogEntry(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  IntervalLogEntry call({
    Object? intensity = const $CopyWithPlaceholder(),
    Object? plannedDuration = const $CopyWithPlaceholder(),
    Object? actualStartTime = const $CopyWithPlaceholder(),
    Object? actualEndTime = const $CopyWithPlaceholder(),
  }) {
    return IntervalLogEntry(
      intensity: intensity == const $CopyWithPlaceholder() || intensity == null
          ? _value.intensity
          // ignore: cast_nullable_to_non_nullable
          : intensity as ExerciseIntensity,
      plannedDuration:
          plannedDuration == const $CopyWithPlaceholder() ||
              plannedDuration == null
          ? _value.plannedDuration
          // ignore: cast_nullable_to_non_nullable
          : plannedDuration as Duration,
      actualStartTime:
          actualStartTime == const $CopyWithPlaceholder() ||
              actualStartTime == null
          ? _value.actualStartTime
          // ignore: cast_nullable_to_non_nullable
          : actualStartTime as DateTime,
      actualEndTime: actualEndTime == const $CopyWithPlaceholder()
          ? _value.actualEndTime
          // ignore: cast_nullable_to_non_nullable
          : actualEndTime as DateTime?,
    );
  }
}

extension $IntervalLogEntryCopyWith on IntervalLogEntry {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfIntervalLogEntry.copyWith(...)` or `instanceOfIntervalLogEntry.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IntervalLogEntryCWProxy get copyWith => _$IntervalLogEntryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContinuousExerciseLog _$ContinuousExerciseLogFromJson(
  Map<String, dynamic> json,
) =>
    ContinuousExerciseLog(
        settings: FMRSettings.fromJson(
          json['settings'] as Map<String, dynamic>,
        ),
        startTime: DateTime.parse(json['startTime'] as String),
        intensity: $enumDecode(_$ExerciseIntensityEnumMap, json['intensity']),
      )
      ..endTime = json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String);

Map<String, dynamic> _$ContinuousExerciseLogToJson(
  ContinuousExerciseLog instance,
) => <String, dynamic>{
  'settings': instance.settings.toJson(),
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'intensity': _$ExerciseIntensityEnumMap[instance.intensity]!,
};

const _$ExerciseIntensityEnumMap = {
  ExerciseIntensity.moderate: 'moderate',
  ExerciseIntensity.vigorous: 'vigorous',
};

IntervalExerciseLog _$IntervalExerciseLogFromJson(Map<String, dynamic> json) =>
    IntervalExerciseLog(
        settings: FMRSettings.fromJson(
          json['settings'] as Map<String, dynamic>,
        ),
        startTime: DateTime.parse(json['startTime'] as String),
      )
      ..endTime = json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String);

Map<String, dynamic> _$IntervalExerciseLogToJson(
  IntervalExerciseLog instance,
) => <String, dynamic>{
  'settings': instance.settings.toJson(),
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
};

IntervalLogEntry _$IntervalLogEntryFromJson(Map<String, dynamic> json) =>
    IntervalLogEntry(
      intensity: $enumDecode(_$ExerciseIntensityEnumMap, json['intensity']),
      plannedDuration: const DurationSecondsConverter().fromJson(
        (json['plannedDuration'] as num).toInt(),
      ),
      actualStartTime: DateTime.parse(json['actualStartTime'] as String),
      actualEndTime: json['actualEndTime'] == null
          ? null
          : DateTime.parse(json['actualEndTime'] as String),
    );

Map<String, dynamic> _$IntervalLogEntryToJson(IntervalLogEntry instance) =>
    <String, dynamic>{
      'intensity': _$ExerciseIntensityEnumMap[instance.intensity]!,
      'plannedDuration': const DurationSecondsConverter().toJson(
        instance.plannedDuration,
      ),
      'actualStartTime': instance.actualStartTime.toIso8601String(),
      'actualEndTime': ?instance.actualEndTime?.toIso8601String(),
    };
