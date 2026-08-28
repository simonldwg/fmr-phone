// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interval.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IntervalCWProxy {
  Interval intensity(ExerciseIntensity intensity);

  Interval duration(Duration duration);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Interval(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Interval(...).copyWith(id: 12, name: "My name")
  /// ```
  Interval call({ExerciseIntensity intensity, Duration duration});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInterval.copyWith(...)` or call `instanceOfInterval.copyWith.fieldName(value)` for a single field.
class _$IntervalCWProxyImpl implements _$IntervalCWProxy {
  const _$IntervalCWProxyImpl(this._value);

  final Interval _value;

  @override
  Interval intensity(ExerciseIntensity intensity) => call(intensity: intensity);

  @override
  Interval duration(Duration duration) => call(duration: duration);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Interval(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Interval(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  Interval call({
    Object? intensity = const $CopyWithPlaceholder(),
    Object? duration = const $CopyWithPlaceholder(),
  }) {
    return Interval(
      intensity == const $CopyWithPlaceholder() || intensity == null
          ? _value.intensity
          // ignore: cast_nullable_to_non_nullable
          : intensity as ExerciseIntensity,
      duration == const $CopyWithPlaceholder() || duration == null
          ? _value.duration
          // ignore: cast_nullable_to_non_nullable
          : duration as Duration,
    );
  }
}

extension $IntervalCopyWith on Interval {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInterval.copyWith(...)` or `instanceOfInterval.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IntervalCWProxy get copyWith => _$IntervalCWProxyImpl(this);
}
