import 'package:json_annotation/json_annotation.dart';

part 'album_short.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AlbumShort {
  String id;
  String albumName;
  String artist;
  String? artworkUrl;

  AlbumShort(this.id, this.albumName, this.artist, this.artworkUrl);

  factory AlbumShort.fromJson(Map<String, dynamic> json) =>
      _$AlbumShortFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumShortToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is! AlbumShort) return false;
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
