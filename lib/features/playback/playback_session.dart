import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'domain/models/playback_mode.dart';

class PlaybackSession extends Notifier<PlaybackMode> {
  @override
  PlaybackMode build() => PlaybackMode.none;

  bool activateLibrary() {
    if (state == PlaybackMode.exercise) return false;
    state = PlaybackMode.library;
    return true;
  }

  void activateExercise() => state = PlaybackMode.exercise;

  void endExercise() {
    if (state == PlaybackMode.exercise) state = PlaybackMode.none;
  }
}
