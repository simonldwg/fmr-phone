import 'package:copy_with_extension/copy_with_extension.dart';
import '../../../library/domain/models/song.dart';

part 'fmr_playback_state.g.dart';

@CopyWith()
class FMRPlaybackState {
  const FMRPlaybackState({
    required this.song,
    required this.playing,
    required this.loading,
    required this.canGoNext,
    required this.canGoPrevious,
  });

  const FMRPlaybackState.idle()
    : song = null,
      playing = false,
      loading = false,
      canGoNext = false,
      canGoPrevious = false;

  final Song? song;
  final bool playing;
  final bool loading;
  final bool canGoNext;
  final bool canGoPrevious;

  @override
  bool operator ==(Object other) =>
      other is FMRPlaybackState &&
      other.song?.id == song?.id &&
      other.playing == playing &&
      other.loading == loading &&
      other.canGoNext == canGoNext &&
      other.canGoPrevious == canGoPrevious;

  @override
  int get hashCode =>
      Object.hash(song?.id, playing, loading, canGoNext, canGoPrevious);
}
