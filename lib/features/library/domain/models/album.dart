import 'package:json_annotation/json_annotation.dart';
import 'album_short.dart';
import 'song.dart';

part 'album.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Album extends AlbumShort {
  List<Song> songs;

  Album(super.id, super.albumName, super.artist, super.artworkUrl, this.songs);

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
