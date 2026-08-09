// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fmr_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FMRSettings _$FMRSettingsFromJson(Map<String, dynamic> json) => FMRSettings(
  json['apiUrl'] as String,
  json['useBasicExerciseScreen'] as bool,
  (json['targetHrModerate'] as num).toInt(),
  (json['targetHrVigorous'] as num).toInt(),
  (json['arousalWeight'] as num).toDouble(),
  (json['bpmWeight'] as num).toDouble(),
  Filters.fromJson(json['filters'] as Map<String, dynamic>),
  json['allowMultiplePlays'] as bool,
  (json['initialBpmModerate'] as num).toInt(),
  (json['initialBpmVigorous'] as num).toInt(),
);

Map<String, dynamic> _$FMRSettingsToJson(FMRSettings instance) =>
    <String, dynamic>{
      'apiUrl': instance.apiUrl,
      'useBasicExerciseScreen': instance.useBasicExerciseScreen,
      'targetHrModerate': instance.targetHrModerate,
      'targetHrVigorous': instance.targetHrVigorous,
      'arousalWeight': instance.arousalWeight,
      'bpmWeight': instance.bpmWeight,
      'filters': instance.filters,
      'allowMultiplePlays': instance.allowMultiplePlays,
      'initialBpmModerate': instance.initialBpmModerate,
      'initialBpmVigorous': instance.initialBpmVigorous,
    };

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
