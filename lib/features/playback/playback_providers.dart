import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../library/domain/models/song.dart';
import 'domain/controllers/library_playback_controller.dart';
import 'domain/fmr_audio_handler.dart';
import 'domain/models/fmr_playback_state.dart';

final audioHandlerProvider = Provider<FMRAudioHandler>((ref) {
  throw UnimplementedError('audioHandlerProvider must be set via an override.');
});

final playbackStateProvider = StreamProvider<FMRPlaybackState>(
  (ref) => ref.watch(audioHandlerProvider).state.distinct(),
);

final currentSongProvider = Provider<Song?>(
  (ref) => ref.watch(playbackStateProvider).valueOrNull?.song,
);

final libraryPlaybackProvider = Provider<LibraryPlayback>(
  (ref) => LibraryPlayback(ref.watch(audioHandlerProvider)),
);
