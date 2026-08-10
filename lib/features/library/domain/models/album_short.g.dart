// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumShort _$AlbumShortFromJson(Map<String, dynamic> json) => AlbumShort(
  json['id'] as String,
  json['album_name'] as String,
  json['artist'] as String,
  json['artwork_url'] as String?,
);

Map<String, dynamic> _$AlbumShortToJson(AlbumShort instance) =>
    <String, dynamic>{
      'id': instance.id,
      'album_name': instance.albumName,
      'artist': instance.artist,
      'artwork_url': instance.artworkUrl,
    };
