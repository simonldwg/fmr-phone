// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
  json['id'] as String,
  json['title'] as String,
  AlbumShort.fromJson(json['album'] as Map<String, dynamic>),
  json['artist'] as String,
  (json['duration_s'] as num).toDouble(),
  SongFeatures.fromJson(json['features'] as Map<String, dynamic>),
  SongGenres.fromJson(json['genres'] as Map<String, dynamic>),
  json['song_url'] as String,
  json['artwork_url'] as String?,
);

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'album': instance.album,
  'artist': instance.artist,
  'duration_s': instance.durationS,
  'features': instance.features,
  'genres': instance.genres,
  'song_url': instance.songUrl,
  'artwork_url': instance.artworkUrl,
};
