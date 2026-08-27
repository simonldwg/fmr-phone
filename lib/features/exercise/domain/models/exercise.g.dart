// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExerciseCWProxy {
  Exercise intensity(ExerciseIntensity intensity);

  Exercise startTime(DateTime startTime);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Exercise(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Exercise(...).copyWith(id: 12, name: "My name")
  /// ```
  Exercise call({ExerciseIntensity intensity, DateTime startTime});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfExercise.copyWith(...)` or call `instanceOfExercise.copyWith.fieldName(value)` for a single field.
class _$ExerciseCWProxyImpl implements _$ExerciseCWProxy {
  const _$ExerciseCWProxyImpl(this._value);

  final Exercise _value;

  @override
  Exercise intensity(ExerciseIntensity intensity) => call(intensity: intensity);

  @override
  Exercise startTime(DateTime startTime) => call(startTime: startTime);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Exercise(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Exercise(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  Exercise call({
    Object? intensity = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
  }) {
    return Exercise(
      intensity == const $CopyWithPlaceholder() || intensity == null
          ? _value.intensity
          // ignore: cast_nullable_to_non_nullable
          : intensity as ExerciseIntensity,
      startTime == const $CopyWithPlaceholder() || startTime == null
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as DateTime,
    );
  }
}

extension $ExerciseCopyWith on Exercise {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfExercise.copyWith(...)` or `instanceOfExercise.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExerciseCWProxy get copyWith => _$ExerciseCWProxyImpl(this);
}
