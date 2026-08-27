import 'package:flutter/foundation.dart';
import '../../playback_session.dart';
import '../fmr_audio_handler.dart';

abstract class PlaybackController {
  PlaybackController(this.handler, this.session);

  @protected
  final FMRAudioHandler handler;

  @protected
  final PlaybackSession session;

  Future<void> next() => handler.skipToNext();

  Future<void> togglePlayPause() =>
      handler.playbackState.value.playing ? handler.pause() : handler.play();

  Future<void> previous() => handler.skipToPrevious();

  Future<void> seek(Duration position) => handler.seek(position);
}
