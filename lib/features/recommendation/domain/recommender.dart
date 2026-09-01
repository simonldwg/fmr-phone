import 'dart:async';

import 'package:fitness_music_recommender/features/recommendation/data/recommendation_repository.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/recommendation.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/recommendation_params.dart';

import '../../library/domain/models/song.dart';

class Recommender {
  int targetHr;
  final double arousalWeight;
  final double bpmWeight;

  final RecommendationRepository _repository;

  Recommender({
    required this.targetHr,
    required this.arousalWeight,
    required this.bpmWeight,
    required RecommendationRepository repository,
  }) : _repository = repository;

  double _relativeDeviation(int currentHr) {
    return (targetHr - currentHr) / targetHr;
  }

  static double _calculateFeature({
    required double previous,
    required double weight,
    required double deviation,
  }) {
    return previous * (1 + weight * deviation);
  }

  Future<(RecommendationParams, Recommendation)> recommendFromHeartRate({
    required int currentHr,
    required Song previousSong,
    required RecommendationParams params,
  }) async {
    // deviation of the current HR from the target HR
    double r = _relativeDeviation(currentHr);

    // calculate arousal and BPM of the new song based on the previous song
    double bpmNew = _calculateFeature(
      previous: previousSong.features.bpm,
      weight: bpmWeight,
      deviation: r,
    );
    double arousalNew = _calculateFeature(
      previous: previousSong.features.arousal,
      weight: arousalWeight,
      deviation: r,
    );

    // append bpm and arousal to the request params
    final requestParams = params.withFeatures(arousal: arousalNew, bpm: bpmNew);

    // fetch recommendation
    final recommendation = await _repository.fetchRecommendation(requestParams);
    return (requestParams, recommendation);
  }

  Future<(RecommendationParams, Recommendation)> recommendInitial({
    required double bpmStart,
    required RecommendationParams params,
  }) async {
    // Recommending the first song of an exercise is static. This is because
    // the deviation from the current HR to the target HR might be too large
    // at the start of the exercise (for example, 50%), which causes the
    // calculated HR values to grow extremely quickly. Thus, we let the user
    // adjust to the exercise first with a static bpm.
    final requestParams = params.withFeatures(bpm: bpmStart);

    // fetch recommendation
    final recommendation = await _repository.fetchRecommendation(requestParams);
    return (requestParams, recommendation);
  }
}
