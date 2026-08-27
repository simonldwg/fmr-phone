import 'package:fitness_music_recommender/features/recommendation/data/recommendation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/data/remote/api_base_providers.dart';
import 'data/remote/recommendation_api_client.dart';

final _recommendationApiClientProvider = Provider<RecommendationApiClient>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return RecommendationApiClient(dio);
});

final recommendationRepositoryProvider = Provider<RecommendationRepository>((
  ref,
) {
  final client = ref.watch(_recommendationApiClientProvider);
  final baseUrl = ref.watch(apiUrlProvider);
  return RecommendationRepository(client, baseUrl);
});
