import 'package:json_annotation/json_annotation.dart';
import 'album_short.dart';
import 'song_features.dart';
import 'song_genres.dart';

part 'song.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Song {
  String id;
  String title;
  AlbumShort album;
  String artist;
  double durationS;
  SongFeatures features;
  SongGenres genres;
  String songUrl;
  String? artworkUrl;

  Song(
    this.id,
    this.title,
    this.album,
    this.artist,
    this.durationS,
    this.features,
    this.genres,
    this.songUrl,
    this.artworkUrl,
  );

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);
}
