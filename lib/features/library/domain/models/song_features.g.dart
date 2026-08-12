// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_features.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongFeatures _$SongFeaturesFromJson(Map<String, dynamic> json) => SongFeatures(
  (json['valence'] as num).toDouble(),
  (json['arousal'] as num).toDouble(),
  (json['authenticity'] as num).toDouble(),
  (json['timeliness'] as num).toDouble(),
  (json['complexity'] as num).toDouble(),
  (json['danceability'] as num).toDouble(),
  (json['tonal'] as num).toDouble(),
  (json['voice'] as num).toDouble(),
  (json['bpm'] as num).toDouble(),
);

Map<String, dynamic> _$SongFeaturesToJson(SongFeatures instance) =>
    <String, dynamic>{
      'valence': instance.valence,
      'arousal': instance.arousal,
      'authenticity': instance.authenticity,
      'timeliness': instance.timeliness,
      'complexity': instance.complexity,
      'danceability': instance.danceability,
      'tonal': instance.tonal,
      'voice': instance.voice,
      'bpm': instance.bpm,
    };
