import 'package:json_annotation/json_annotation.dart';

import 'genre.dart';

part 'song_genres.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SongGenres {
  Map<Genre, double> top3Genres;
  Map<Genre, double> allGenres;

  SongGenres(this.top3Genres, this.allGenres);

  factory SongGenres.fromJson(Map<String, dynamic> json) =>
      _$SongGenresFromJson(json);
  Map<String, dynamic> toJson() => _$SongGenresToJson(this);
}
