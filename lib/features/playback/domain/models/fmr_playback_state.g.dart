// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fmr_playback_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FMRPlaybackStateCWProxy {
  FMRPlaybackState song(Song? song);

  FMRPlaybackState playing(bool playing);

  FMRPlaybackState loading(bool loading);

  FMRPlaybackState canGoNext(bool canGoNext);

  FMRPlaybackState canGoPrevious(bool canGoPrevious);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FMRPlaybackState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FMRPlaybackState(...).copyWith(id: 12, name: "My name")
  /// ```
  FMRPlaybackState call({
    Song? song,
    bool playing,
    bool loading,
    bool canGoNext,
    bool canGoPrevious,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFMRPlaybackState.copyWith(...)` or call `instanceOfFMRPlaybackState.copyWith.fieldName(value)` for a single field.
class _$FMRPlaybackStateCWProxyImpl implements _$FMRPlaybackStateCWProxy {
  const _$FMRPlaybackStateCWProxyImpl(this._value);

  final FMRPlaybackState _value;

  @override
  FMRPlaybackState song(Song? song) => call(song: song);

  @override
  FMRPlaybackState playing(bool playing) => call(playing: playing);

  @override
  FMRPlaybackState loading(bool loading) => call(loading: loading);

  @override
  FMRPlaybackState canGoNext(bool canGoNext) => call(canGoNext: canGoNext);

  @override
  FMRPlaybackState canGoPrevious(bool canGoPrevious) =>
      call(canGoPrevious: canGoPrevious);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FMRPlaybackState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FMRPlaybackState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  FMRPlaybackState call({
    Object? song = const $CopyWithPlaceholder(),
    Object? playing = const $CopyWithPlaceholder(),
    Object? loading = const $CopyWithPlaceholder(),
    Object? canGoNext = const $CopyWithPlaceholder(),
    Object? canGoPrevious = const $CopyWithPlaceholder(),
  }) {
    return FMRPlaybackState(
      song: song == const $CopyWithPlaceholder()
          ? _value.song
          // ignore: cast_nullable_to_non_nullable
          : song as Song?,
      playing: playing == const $CopyWithPlaceholder() || playing == null
          ? _value.playing
          // ignore: cast_nullable_to_non_nullable
          : playing as bool,
      loading: loading == const $CopyWithPlaceholder() || loading == null
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool,
      canGoNext: canGoNext == const $CopyWithPlaceholder() || canGoNext == null
          ? _value.canGoNext
          // ignore: cast_nullable_to_non_nullable
          : canGoNext as bool,
      canGoPrevious:
          canGoPrevious == const $CopyWithPlaceholder() || canGoPrevious == null
          ? _value.canGoPrevious
          // ignore: cast_nullable_to_non_nullable
          : canGoPrevious as bool,
    );
  }
}

extension $FMRPlaybackStateCopyWith on FMRPlaybackState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFMRPlaybackState.copyWith(...)` or `instanceOfFMRPlaybackState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FMRPlaybackStateCWProxy get copyWith => _$FMRPlaybackStateCWProxyImpl(this);
}
