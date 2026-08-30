import 'package:fitness_music_recommender/features/playback/domain/controllers/playback_controller.dart';
import 'package:fitness_music_recommender/features/playback/domain/sources/recommendation_source.dart';
import 'package:fitness_music_recommender/features/recommendation/data/recommendation_repository.dart';
import 'package:fitness_music_recommender/features/settings/domain/models/fmr_settings.dart';
import 'package:flutter/foundation.dart';

import '../../../exercise/domain/models/exercise_intensity.dart';
import '../../../recommendation/domain/models/extensions/filters_to_recommendation_params.dart';
import '../../../recommendation/domain/recommender.dart';
import '../../../recommendation/domain/song_selector.dart';

class ExercisePlaybackController extends PlaybackController {
  final FMRSettings _settings;
  final RecommendationRepository _recommendationRepository;
  RecommendationSource? _source;

  ExercisePlaybackController(
    super.handler,
    super.session,
    this._settings,
    this._recommendationRepository,
  );

  Future<void> startWithIntensity({
    required ExerciseIntensity exerciseIntensity,
    required ValueGetter<int> getCurrentHeartRate,
  }) async {
    final recommender = Recommender(
      targetHr: _settings.heartRateFor(exerciseIntensity),
      arousalWeight: _settings.arousalWeight,
      bpmWeight: _settings.bpmWeight,
      repository: _recommendationRepository,
    );

    final songSelector = SongSelector(
      strategy: _settings.selectionStrategy,
      allowMultiplePlays: _settings.allowMultiplePlays,
    );

    final initialBpm = _settings.initialBpmFor(exerciseIntensity).toDouble();

    final source = RecommendationSource(
      recommender: recommender,
      songSelector: songSelector,
      baseParams: _settings.filters.toRecommendationParams(),
      getCurrentHeartRate: getCurrentHeartRate,
      getCurrentPosition: () => handler.position,
      initialBpm: initialBpm,
    );
    _source = source;

    session.activateExercise();
    handler.setSource(source);
    await handler.startPlayingFromCurrentPosition();
  }

  Future<void> updateTargetIntensity(ExerciseIntensity intensity) async {
    _source?.updateTargetHeartRate(_settings.heartRateFor(intensity));
    _source?.forceNewRecommendationOnNextSong();
    await next();
  }

  Future<void> stop({
    bool fadeOut = false,
    Duration fadeOutDuration = const Duration(seconds: 3),
  }) async {
    await handler.stop(fadeOut: fadeOut, fadeOutDuration: fadeOutDuration);
    session.endExercise();
    _source = null;
  }
}
