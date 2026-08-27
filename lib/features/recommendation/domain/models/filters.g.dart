// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FiltersCWProxy {
  Filters genres(Set<Genre> genres);

  Filters songLength(LengthFilter songLength);

  Filters valence(FeatureFilter valence);

  Filters authenticity(FeatureFilter authenticity);

  Filters timeliness(FeatureFilter timeliness);

  Filters complexity(FeatureFilter complexity);

  Filters danceability(FeatureFilter danceability);

  Filters tonal(FeatureFilter tonal);

  Filters voice(FeatureFilter voice);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Filters(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Filters(...).copyWith(id: 12, name: "My name")
  /// ```
  Filters call({
    Set<Genre> genres,
    LengthFilter songLength,
    FeatureFilter valence,
    FeatureFilter authenticity,
    FeatureFilter timeliness,
    FeatureFilter complexity,
    FeatureFilter danceability,
    FeatureFilter tonal,
    FeatureFilter voice,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFilters.copyWith(...)` or call `instanceOfFilters.copyWith.fieldName(value)` for a single field.
class _$FiltersCWProxyImpl implements _$FiltersCWProxy {
  const _$FiltersCWProxyImpl(this._value);

  final Filters _value;

  @override
  Filters genres(Set<Genre> genres) => call(genres: genres);

  @override
  Filters songLength(LengthFilter songLength) => call(songLength: songLength);

  @override
  Filters valence(FeatureFilter valence) => call(valence: valence);

  @override
  Filters authenticity(FeatureFilter authenticity) =>
      call(authenticity: authenticity);

  @override
  Filters timeliness(FeatureFilter timeliness) => call(timeliness: timeliness);

  @override
  Filters complexity(FeatureFilter complexity) => call(complexity: complexity);

  @override
  Filters danceability(FeatureFilter danceability) =>
      call(danceability: danceability);

  @override
  Filters tonal(FeatureFilter tonal) => call(tonal: tonal);

  @override
  Filters voice(FeatureFilter voice) => call(voice: voice);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Filters(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Filters(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  Filters call({
    Object? genres = const $CopyWithPlaceholder(),
    Object? songLength = const $CopyWithPlaceholder(),
    Object? valence = const $CopyWithPlaceholder(),
    Object? authenticity = const $CopyWithPlaceholder(),
    Object? timeliness = const $CopyWithPlaceholder(),
    Object? complexity = const $CopyWithPlaceholder(),
    Object? danceability = const $CopyWithPlaceholder(),
    Object? tonal = const $CopyWithPlaceholder(),
    Object? voice = const $CopyWithPlaceholder(),
  }) {
    return Filters(
      genres == const $CopyWithPlaceholder() || genres == null
          ? _value.genres
          // ignore: cast_nullable_to_non_nullable
          : genres as Set<Genre>,
      songLength == const $CopyWithPlaceholder() || songLength == null
          ? _value.songLength
          // ignore: cast_nullable_to_non_nullable
          : songLength as LengthFilter,
      valence == const $CopyWithPlaceholder() || valence == null
          ? _value.valence
          // ignore: cast_nullable_to_non_nullable
          : valence as FeatureFilter,
      authenticity == const $CopyWithPlaceholder() || authenticity == null
          ? _value.authenticity
          // ignore: cast_nullable_to_non_nullable
          : authenticity as FeatureFilter,
      timeliness == const $CopyWithPlaceholder() || timeliness == null
          ? _value.timeliness
          // ignore: cast_nullable_to_non_nullable
          : timeliness as FeatureFilter,
      complexity == const $CopyWithPlaceholder() || complexity == null
          ? _value.complexity
          // ignore: cast_nullable_to_non_nullable
          : complexity as FeatureFilter,
      danceability == const $CopyWithPlaceholder() || danceability == null
          ? _value.danceability
          // ignore: cast_nullable_to_non_nullable
          : danceability as FeatureFilter,
      tonal == const $CopyWithPlaceholder() || tonal == null
          ? _value.tonal
          // ignore: cast_nullable_to_non_nullable
          : tonal as FeatureFilter,
      voice == const $CopyWithPlaceholder() || voice == null
          ? _value.voice
          // ignore: cast_nullable_to_non_nullable
          : voice as FeatureFilter,
    );
  }
}

extension $FiltersCopyWith on Filters {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFilters.copyWith(...)` or `instanceOfFilters.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FiltersCWProxy get copyWith => _$FiltersCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
  (json['genres'] as List<dynamic>)
      .map((e) => $enumDecode(_$GenreEnumMap, e))
      .toSet(),
  LengthFilter.fromJson(json['songLength'] as Map<String, dynamic>),
  FeatureFilter.fromJson(json['valence'] as Map<String, dynamic>),
  FeatureFilter.fromJson(json['authenticity'] as Map<String, dynamic>),
  FeatureFilter.fromJson(json['timeliness'] as Map<String, dynamic>),
  FeatureFilter.fromJson(json['complexity'] as Map<String, dynamic>),
  FeatureFilter.fromJson(json['danceability'] as Map<String, dynamic>),
  FeatureFilter.fromJson(json['tonal'] as Map<String, dynamic>),
  FeatureFilter.fromJson(json['voice'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
  'genres': instance.genres.map((e) => _$GenreEnumMap[e]!).toList(),
  'songLength': instance.songLength,
  'valence': instance.valence,
  'authenticity': instance.authenticity,
  'timeliness': instance.timeliness,
  'complexity': instance.complexity,
  'danceability': instance.danceability,
  'tonal': instance.tonal,
  'voice': instance.voice,
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

LengthFilter _$LengthFilterFromJson(Map<String, dynamic> json) =>
    LengthFilter((json['seconds'] as num).toInt(), json['enabled'] as bool);

Map<String, dynamic> _$LengthFilterToJson(LengthFilter instance) =>
    <String, dynamic>{'seconds': instance.seconds, 'enabled': instance.enabled};

FeatureFilter _$FeatureFilterFromJson(Map<String, dynamic> json) =>
    FeatureFilter((json['value'] as num).toDouble(), json['enabled'] as bool);

Map<String, dynamic> _$FeatureFilterToJson(FeatureFilter instance) =>
    <String, dynamic>{'value': instance.value, 'enabled': instance.enabled};
