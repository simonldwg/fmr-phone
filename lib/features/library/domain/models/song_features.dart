import 'package:json_annotation/json_annotation.dart';
part 'song_features.g.dart';

@JsonSerializable()
class SongFeatures {
  double valence;
  double arousal;
  double authenticity;
  double timeliness;
  double complexity;
  double danceability;
  double tonal;
  double voice;
  double bpm;

  SongFeatures(
    this.valence,
    this.arousal,
    this.authenticity,
    this.timeliness,
    this.complexity,
    this.danceability,
    this.tonal,
    this.voice,
    this.bpm,
  );

  factory SongFeatures.fromJson(Map<String, dynamic> json) =>
      _$SongFeaturesFromJson(json);
  Map<String, dynamic> toJson() => _$SongFeaturesToJson(this);
}
