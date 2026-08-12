// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
  json['id'] as String,
  json['album_name'] as String,
  json['artist'] as String,
  json['artwork_url'] as String?,
  (json['songs'] as List<dynamic>)
      .map((e) => Song.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
  'id': instance.id,
  'album_name': instance.albumName,
  'artist': instance.artist,
  'artwork_url': instance.artworkUrl,
  'songs': instance.songs,
};
