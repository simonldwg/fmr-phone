import 'package:fitness_music_recommender/features/library/domain/models/extensions/url_resolver.dart';
import 'package:fitness_music_recommender/features/recommendation/data/remote/recommendation_api_client.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/recommendation_params.dart';

import '../../library/domain/models/song.dart';
import '../domain/models/recommendation.dart';

class RecommendationRepository {
  final RecommendationApiClient _client;
  final String _baseUrl;

  RecommendationRepository(this._client, this._baseUrl);

  Future<Recommendation> fetchRecommendation(
    RecommendationParams params,
  ) async {
    final recommendation = await _client.fetchRecommendation(params);
    for (Song song in recommendation.playlist) {
      song.resolveUrls(_baseUrl);
    }
    return recommendation;
  }
}
