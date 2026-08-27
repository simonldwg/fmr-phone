import 'package:dio/dio.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/recommendation.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/recommendation_params.dart';

part 'recommendation_api_client.g.dart';

@RestApi(baseUrl: '/recommend')
abstract class RecommendationApiClient {
  factory RecommendationApiClient(Dio dio, {String? baseUrl}) =
      _RecommendationApiClient;

  @POST('/playlist')
  Future<Recommendation> fetchRecommendation(
    @Body() RecommendationParams params,
  );
}
