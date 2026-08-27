import 'package:json_annotation/json_annotation.dart';
import '../../../library/domain/models/song.dart';
import '../exceptions/recommendation_exception.dart';

part 'recommendation.g.dart';

@JsonSerializable()
class Recommendation {
  List<Song> playlist;
  String? message;

  Recommendation(this.playlist, this.message);

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    final recommendation = _$RecommendationFromJson(json);
    if (recommendation.message != null) {
      throw RecommendationException(recommendation.message!);
    }
    return recommendation;
  }

  Map<String, dynamic> toJson() => _$RecommendationToJson(this);
}
