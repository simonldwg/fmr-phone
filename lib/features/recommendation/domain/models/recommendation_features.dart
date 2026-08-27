import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation_features.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false)
class RecommendationFeatures {
  double? valence;
  double? arousal;
  double? authenticity;
  double? timeliness;
  double? complexity;
  double? danceability;
  double? tonal;
  double? voice;
  double? bpm;

  RecommendationFeatures({
    this.valence,
    this.arousal,
    this.authenticity,
    this.timeliness,
    this.complexity,
    this.danceability,
    this.tonal,
    this.voice,
    this.bpm,
  });

  factory RecommendationFeatures.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFeaturesFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationFeaturesToJson(this);
}
