// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExerciseStateCWProxy {
  ExerciseState exercise(Exercise? exercise);

  ExerciseState latestHeartRate(int? latestHeartRate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ExerciseState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ExerciseState(...).copyWith(id: 12, name: "My name")
  /// ```
  ExerciseState call({Exercise? exercise, int? latestHeartRate});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfExerciseState.copyWith(...)` or call `instanceOfExerciseState.copyWith.fieldName(value)` for a single field.
class _$ExerciseStateCWProxyImpl implements _$ExerciseStateCWProxy {
  const _$ExerciseStateCWProxyImpl(this._value);

  final ExerciseState _value;

  @override
  ExerciseState exercise(Exercise? exercise) => call(exercise: exercise);

  @override
  ExerciseState latestHeartRate(int? latestHeartRate) =>
      call(latestHeartRate: latestHeartRate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ExerciseState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ExerciseState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ExerciseState call({
    Object? exercise = const $CopyWithPlaceholder(),
    Object? latestHeartRate = const $CopyWithPlaceholder(),
  }) {
    return ExerciseState(
      exercise: exercise == const $CopyWithPlaceholder()
          ? _value.exercise
          // ignore: cast_nullable_to_non_nullable
          : exercise as Exercise?,
      latestHeartRate: latestHeartRate == const $CopyWithPlaceholder()
          ? _value.latestHeartRate
          // ignore: cast_nullable_to_non_nullable
          : latestHeartRate as int?,
    );
  }
}

extension $ExerciseStateCopyWith on ExerciseState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfExerciseState.copyWith(...)` or `instanceOfExerciseState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExerciseStateCWProxy get copyWith => _$ExerciseStateCWProxyImpl(this);
}
