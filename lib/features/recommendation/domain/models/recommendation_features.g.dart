// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_features.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RecommendationFeaturesCWProxy {
  RecommendationFeatures valence(double? valence);

  RecommendationFeatures arousal(double? arousal);

  RecommendationFeatures authenticity(double? authenticity);

  RecommendationFeatures timeliness(double? timeliness);

  RecommendationFeatures complexity(double? complexity);

  RecommendationFeatures danceability(double? danceability);

  RecommendationFeatures tonal(double? tonal);

  RecommendationFeatures voice(double? voice);

  RecommendationFeatures bpm(double? bpm);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RecommendationFeatures(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RecommendationFeatures(...).copyWith(id: 12, name: "My name")
  /// ```
  RecommendationFeatures call({
    double? valence,
    double? arousal,
    double? authenticity,
    double? timeliness,
    double? complexity,
    double? danceability,
    double? tonal,
    double? voice,
    double? bpm,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRecommendationFeatures.copyWith(...)` or call `instanceOfRecommendationFeatures.copyWith.fieldName(value)` for a single field.
class _$RecommendationFeaturesCWProxyImpl
    implements _$RecommendationFeaturesCWProxy {
  const _$RecommendationFeaturesCWProxyImpl(this._value);

  final RecommendationFeatures _value;

  @override
  RecommendationFeatures valence(double? valence) => call(valence: valence);

  @override
  RecommendationFeatures arousal(double? arousal) => call(arousal: arousal);

  @override
  RecommendationFeatures authenticity(double? authenticity) =>
      call(authenticity: authenticity);

  @override
  RecommendationFeatures timeliness(double? timeliness) =>
      call(timeliness: timeliness);

  @override
  RecommendationFeatures complexity(double? complexity) =>
      call(complexity: complexity);

  @override
  RecommendationFeatures danceability(double? danceability) =>
      call(danceability: danceability);

  @override
  RecommendationFeatures tonal(double? tonal) => call(tonal: tonal);

  @override
  RecommendationFeatures voice(double? voice) => call(voice: voice);

  @override
  RecommendationFeatures bpm(double? bpm) => call(bpm: bpm);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RecommendationFeatures(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RecommendationFeatures(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RecommendationFeatures call({
    Object? valence = const $CopyWithPlaceholder(),
    Object? arousal = const $CopyWithPlaceholder(),
    Object? authenticity = const $CopyWithPlaceholder(),
    Object? timeliness = const $CopyWithPlaceholder(),
    Object? complexity = const $CopyWithPlaceholder(),
    Object? danceability = const $CopyWithPlaceholder(),
    Object? tonal = const $CopyWithPlaceholder(),
    Object? voice = const $CopyWithPlaceholder(),
    Object? bpm = const $CopyWithPlaceholder(),
  }) {
    return RecommendationFeatures(
      valence: valence == const $CopyWithPlaceholder()
          ? _value.valence
          // ignore: cast_nullable_to_non_nullable
          : valence as double?,
      arousal: arousal == const $CopyWithPlaceholder()
          ? _value.arousal
          // ignore: cast_nullable_to_non_nullable
          : arousal as double?,
      authenticity: authenticity == const $CopyWithPlaceholder()
          ? _value.authenticity
          // ignore: cast_nullable_to_non_nullable
          : authenticity as double?,
      timeliness: timeliness == const $CopyWithPlaceholder()
          ? _value.timeliness
          // ignore: cast_nullable_to_non_nullable
          : timeliness as double?,
      complexity: complexity == const $CopyWithPlaceholder()
          ? _value.complexity
          // ignore: cast_nullable_to_non_nullable
          : complexity as double?,
      danceability: danceability == const $CopyWithPlaceholder()
          ? _value.danceability
          // ignore: cast_nullable_to_non_nullable
          : danceability as double?,
      tonal: tonal == const $CopyWithPlaceholder()
          ? _value.tonal
          // ignore: cast_nullable_to_non_nullable
          : tonal as double?,
      voice: voice == const $CopyWithPlaceholder()
          ? _value.voice
          // ignore: cast_nullable_to_non_nullable
          : voice as double?,
      bpm: bpm == const $CopyWithPlaceholder()
          ? _value.bpm
          // ignore: cast_nullable_to_non_nullable
          : bpm as double?,
    );
  }
}

extension $RecommendationFeaturesCopyWith on RecommendationFeatures {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRecommendationFeatures.copyWith(...)` or `instanceOfRecommendationFeatures.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RecommendationFeaturesCWProxy get copyWith =>
      _$RecommendationFeaturesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationFeatures _$RecommendationFeaturesFromJson(
  Map<String, dynamic> json,
) => RecommendationFeatures(
  valence: (json['valence'] as num?)?.toDouble(),
  arousal: (json['arousal'] as num?)?.toDouble(),
  authenticity: (json['authenticity'] as num?)?.toDouble(),
  timeliness: (json['timeliness'] as num?)?.toDouble(),
  complexity: (json['complexity'] as num?)?.toDouble(),
  danceability: (json['danceability'] as num?)?.toDouble(),
  tonal: (json['tonal'] as num?)?.toDouble(),
  voice: (json['voice'] as num?)?.toDouble(),
  bpm: (json['bpm'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RecommendationFeaturesToJson(
  RecommendationFeatures instance,
) => <String, dynamic>{
  'valence': ?instance.valence,
  'arousal': ?instance.arousal,
  'authenticity': ?instance.authenticity,
  'timeliness': ?instance.timeliness,
  'complexity': ?instance.complexity,
  'danceability': ?instance.danceability,
  'tonal': ?instance.tonal,
  'voice': ?instance.voice,
  'bpm': ?instance.bpm,
};
