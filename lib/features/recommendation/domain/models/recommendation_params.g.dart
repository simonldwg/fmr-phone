// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_params.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RecommendationParamsCWProxy {
  RecommendationParams features(RecommendationFeatures? features);

  RecommendationParams length(int? length);

  RecommendationParams genreFilters(List<Genre>? genreFilters);

  RecommendationParams maxSongLengthFilter(double? maxSongLengthFilter);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RecommendationParams(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RecommendationParams(...).copyWith(id: 12, name: "My name")
  /// ```
  RecommendationParams call({
    RecommendationFeatures? features,
    int? length,
    List<Genre>? genreFilters,
    double? maxSongLengthFilter,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRecommendationParams.copyWith(...)` or call `instanceOfRecommendationParams.copyWith.fieldName(value)` for a single field.
class _$RecommendationParamsCWProxyImpl
    implements _$RecommendationParamsCWProxy {
  const _$RecommendationParamsCWProxyImpl(this._value);

  final RecommendationParams _value;

  @override
  RecommendationParams features(RecommendationFeatures? features) =>
      call(features: features);

  @override
  RecommendationParams length(int? length) => call(length: length);

  @override
  RecommendationParams genreFilters(List<Genre>? genreFilters) =>
      call(genreFilters: genreFilters);

  @override
  RecommendationParams maxSongLengthFilter(double? maxSongLengthFilter) =>
      call(maxSongLengthFilter: maxSongLengthFilter);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RecommendationParams(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RecommendationParams(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  RecommendationParams call({
    Object? features = const $CopyWithPlaceholder(),
    Object? length = const $CopyWithPlaceholder(),
    Object? genreFilters = const $CopyWithPlaceholder(),
    Object? maxSongLengthFilter = const $CopyWithPlaceholder(),
  }) {
    return RecommendationParams(
      features: features == const $CopyWithPlaceholder()
          ? _value.features
          // ignore: cast_nullable_to_non_nullable
          : features as RecommendationFeatures?,
      length: length == const $CopyWithPlaceholder()
          ? _value.length
          // ignore: cast_nullable_to_non_nullable
          : length as int?,
      genreFilters: genreFilters == const $CopyWithPlaceholder()
          ? _value.genreFilters
          // ignore: cast_nullable_to_non_nullable
          : genreFilters as List<Genre>?,
      maxSongLengthFilter: maxSongLengthFilter == const $CopyWithPlaceholder()
          ? _value.maxSongLengthFilter
          // ignore: cast_nullable_to_non_nullable
          : maxSongLengthFilter as double?,
    );
  }
}

extension $RecommendationParamsCopyWith on RecommendationParams {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRecommendationParams.copyWith(...)` or `instanceOfRecommendationParams.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RecommendationParamsCWProxy get copyWith =>
      _$RecommendationParamsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationParams _$RecommendationParamsFromJson(
  Map<String, dynamic> json,
) => RecommendationParams(
  features: json['features'] == null
      ? null
      : RecommendationFeatures.fromJson(
          json['features'] as Map<String, dynamic>,
        ),
  length: (json['length'] as num?)?.toInt(),
  genreFilters: (json['genre_filters'] as List<dynamic>?)
      ?.map((e) => $enumDecode(_$GenreEnumMap, e))
      .toList(),
  maxSongLengthFilter: (json['max_song_length_filter'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RecommendationParamsToJson(
  RecommendationParams instance,
) => <String, dynamic>{
  'features': ?instance.features,
  'length': ?instance.length,
  'genre_filters': ?instance.genreFilters
      ?.map((e) => _$GenreEnumMap[e]!)
      .toList(),
  'max_song_length_filter': ?instance.maxSongLengthFilter,
};

const _$GenreEnumMap = {
  Genre.rock: 'Rock',
  Genre.pop: 'Pop',
  Genre.alternative: 'Alternative',
  Genre.indie: 'Indie',
  Genre.electronic: 'Electronic',
  Genre.dance: 'Dance',
  Genre.alternativeRock: 'Alternative Rock',
  Genre.jazz: 'Jazz',
  Genre.metal: 'Metal',
  Genre.chillout: 'Chillout',
  Genre.classicRock: 'Classic Rock',
  Genre.soul: 'Soul',
  Genre.indieRock: 'Indie Rock',
  Genre.electronica: 'Electronica',
  Genre.folk: 'Folk',
  Genre.chill: 'Chill',
  Genre.instrumental: 'Instrumental',
  Genre.punk: 'Punk',
  Genre.blues: 'Blues',
  Genre.hardRock: 'Hard Rock',
  Genre.ambient: 'Ambient',
  Genre.acoustic: 'Acoustic',
  Genre.experimental: 'Experimental',
  Genre.hipHop: 'Hip-Hop',
  Genre.country: 'Country',
  Genre.easyListening: 'Easy Listening',
  Genre.funk: 'Funk',
  Genre.electro: 'Electro',
  Genre.heavyMetal: 'Heavy Metal',
  Genre.progressiveRock: 'Progressive Rock',
  Genre.rnb: 'RnB',
  Genre.indiePop: 'Indie Pop',
  Genre.house: 'House',
};
