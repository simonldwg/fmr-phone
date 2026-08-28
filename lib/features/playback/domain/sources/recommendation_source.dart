import 'package:flutter/foundation.dart';
import 'package:fitness_music_recommender/features/library/domain/models/song.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/recommender.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/song_selector.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/recommendation_params.dart';
import '../../../recommendation/domain/models/recommendation.dart';
import 'playback_source.dart';
import 'playback_source_exception.dart';

class RecommendationSource implements PlaybackSource {
  RecommendationSource({
    required Recommender recommender,
    required SongSelector songSelector,
    required RecommendationParams baseParams,
    required ValueGetter<int> getCurrentHeartRate,
    required ValueGetter<Duration> getCurrentPosition,
    required double initialBpm,
    this.minSecondsPlayedForNewRecommendation = 60,
  }) : _recommender = recommender,
       _songSelector = songSelector,
       _baseParams = baseParams,
       _getCurrentHeartRate = getCurrentHeartRate,
       _getCurrentPosition = getCurrentPosition,
       _initialBpm = initialBpm;

  final Recommender _recommender;
  final SongSelector _songSelector;
  final RecommendationParams _baseParams;
  final ValueGetter<int> _getCurrentHeartRate;
  final ValueGetter<Duration> _getCurrentPosition;
  final double _initialBpm;
  final double minSecondsPlayedForNewRecommendation;
  bool _forceNewRecommendation = false;

  Song? _currentSong;
  Recommendation? _lastRecommendation;

  @override
  Future<Song> getCurrentSong() async => _currentSong ?? await next();

  @override
  Future<Song> next() async {
    final Song song;

    if (_currentSong == null) {
      // First song: use the initial bpm and select a random song from the
      // playlist

      final recommendation = await _recommender.recommendInitial(
        bpmStart: _initialBpm,
        params: _baseParams,
      );
      _lastRecommendation = recommendation;
      song = _songSelector.selectRandomSong(recommendation);
    } else if (_playedEnoughForNewRecommendation() || _forceNewRecommendation) {
      // New recommendations are only generated if the song has been playing for
      // more than minSecondsPlayedForNewRecommendation seconds (see the code for
      // _playedEnoughForNewRecommendation())

      final hr = _getCurrentHeartRate();
      final recommendation = await _recommender.recommendFromHeartRate(
        currentHr: hr,
        previousSong: _currentSong!,
        params: _baseParams,
      );
      _lastRecommendation = recommendation;
      song = _songSelector.selectSong(recommendation);
    } else {
      // Song has not been played long enough -> choose a new song from the
      // existing playlist
      song = _songSelector.selectSong(_lastRecommendation!);
    }

    _currentSong = song;
    _forceNewRecommendation = false;
    return song;
  }

  bool _playedEnoughForNewRecommendation() {
    final playedS = _getCurrentPosition().inSeconds;
    return minSecondsPlayedForNewRecommendation <= playedS;
  }

  /// Useful when exercise intensities are updated and we want to generate a new
  /// recommendation regardless of the time the song has already played.
  void forceNewRecommendationOnNextSong() {
    _forceNewRecommendation = true;
  }

  void updateTargetHeartRate(int targetHr) {
    _recommender.targetHr = targetHr;
  }

  @override
  Future<Song> previous() =>
      throw PlaybackSourceException('Not allowed with a RecommendationSource');

  @override
  bool canGoNext() => true;

  @override
  bool canGoPrevious() => false;
}
