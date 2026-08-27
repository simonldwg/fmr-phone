import 'package:fitness_music_recommender/features/recommendation/domain/models/filters.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/recommendation_params.dart';

import '../recommendation_features.dart';

extension FiltersToRecommendationParams on Filters {
  RecommendationParams toRecommendationParams() => RecommendationParams(
    genreFilters: genres.isEmpty ? null : genres.toList(),
    maxSongLengthFilter: songLength.enabled
        ? songLength.seconds.toDouble()
        : null,
    features: RecommendationFeatures(
      valence: valence.enabled ? valence.value : null,
      authenticity: authenticity.enabled ? authenticity.value : null,
      timeliness: timeliness.enabled ? timeliness.value : null,
      complexity: complexity.enabled ? complexity.value : null,
      danceability: danceability.enabled ? danceability.value : null,
      tonal: tonal.enabled ? tonal.value : null,
      voice: voice.enabled ? voice.value : null,
    ),
  );
}
