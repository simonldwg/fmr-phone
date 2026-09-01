import 'package:fitness_music_recommender/features/logging/logging_providers.dart';
import 'package:fitness_music_recommender/features/playback/domain/controllers/exercise_playback_controller.dart';
import 'package:fitness_music_recommender/features/playback/playback_session.dart';
import 'package:fitness_music_recommender/features/recommendation/recommendation_providers.dart';
import 'package:fitness_music_recommender/features/settings/data/settings_controller_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../library/domain/models/song.dart';
import 'domain/controllers/library_playback_controller.dart';
import 'domain/controllers/playback_controller.dart';
import 'domain/fmr_audio_handler.dart';
import 'domain/models/fmr_playback_state.dart';
import 'domain/models/playback_mode.dart';

final audioHandlerProvider = Provider<FMRAudioHandler>((ref) {
  throw UnimplementedError('audioHandlerProvider must be set via an override.');
});

final playbackStateProvider = StreamProvider<FMRPlaybackState>(
  (ref) => ref.watch(audioHandlerProvider).state.distinct(),
);

final currentSongProvider = Provider<Song?>(
  (ref) => ref.watch(playbackStateProvider).valueOrNull?.song,
);

final playbackSessionProvider = NotifierProvider<PlaybackSession, PlaybackMode>(
  PlaybackSession.new,
);

final libraryPlaybackProvider = Provider<LibraryPlaybackController>(
  (ref) => LibraryPlaybackController(
    ref.watch(audioHandlerProvider),
    ref.watch(playbackSessionProvider.notifier),
  ),
);

final exercisePlaybackProvider = Provider<ExercisePlaybackController>(
  (ref) => ExercisePlaybackController(
    ref.watch(audioHandlerProvider),
    ref.watch(playbackSessionProvider.notifier),
    ref.watch(settingsControllerProvider).requireSettings,
    ref.watch(recommendationRepositoryProvider),
    ref.watch(exerciseLoggerProvider),
  ),
);

final activePlaybackProvider = Provider<PlaybackController?>((ref) {
  return switch (ref.watch(playbackSessionProvider)) {
    PlaybackMode.none => null,
    PlaybackMode.library => ref.watch(libraryPlaybackProvider),
    PlaybackMode.exercise => ref.watch(exercisePlaybackProvider),
  };
});
