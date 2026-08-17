import 'package:flutter/foundation.dart';
import '../fmr_audio_handler.dart';

abstract class PlaybackController {
  PlaybackController(this.handler);

  @protected
  final FMRAudioHandler handler;

  Future<void> next() => handler.skipToNext();

  Future<void> togglePlayPause() =>
      handler.playbackState.value.playing ? handler.pause() : handler.play();

  Future<void> previous() => handler.skipToPrevious();
}
