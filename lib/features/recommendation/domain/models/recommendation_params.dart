import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../library/domain/models/genre.dart';
import 'recommendation_features.dart';

part 'recommendation_params.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class RecommendationParams {
  final RecommendationFeatures? features;
  final int? length;
  final List<Genre>? genreFilters;
  final double? maxSongLengthFilter;

  RecommendationParams({
    this.features,
    this.length,
    this.genreFilters,
    this.maxSongLengthFilter,
  });

  factory RecommendationParams.fromJson(Map<String, dynamic> json) =>
      _$RecommendationParamsFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationParamsToJson(this);

  RecommendationParams withFeatures({
    double? valence,
    double? arousal,
    double? authenticity,
    double? timeliness,
    double? complexity,
    double? danceability,
    double? tonal,
    double? voice,
    double? bpm,
  }) {
    return copyWith(
      features: (features ?? RecommendationFeatures()).copyWith(
        valence: valence,
        arousal: arousal,
        authenticity: authenticity,
        timeliness: timeliness,
        complexity: complexity,
        danceability: danceability,
        tonal: tonal,
        voice: voice,
        bpm: bpm,
      ),
    );
  }
}
