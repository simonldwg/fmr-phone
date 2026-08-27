import 'package:fitness_music_recommender/features/playback/ui/widgets/player_seek_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../library/ui/widgets/artwork_image.dart';
import '../../domain/models/fmr_playback_state.dart';
import '../../playback_providers.dart';

class FullPlayer extends ConsumerWidget {
  const FullPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackController = ref.watch(activePlaybackProvider);
    final state =
        ref.watch(playbackStateProvider).valueOrNull ??
        const FMRPlaybackState.idle();
    final song = state.song;

    if (song == null || playbackController == null) {
      return const SizedBox.shrink();
    }

    final colors = context.theme.colors;
    final typography = context.theme.typography;

    void processSwipe(details) {
      final v = details.primaryVelocity ?? 0;
      if (v < 0 && state.canGoNext) {
        playbackController.next();
      } else if (v > 0 && state.canGoPrevious) {
        playbackController.previous();
      }
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragEnd: processSwipe,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ArtworkImage(
                      url: song.album.artworkUrl,
                      iconSize: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextScroll(
                  key: ValueKey(song.id),
                  song.title,
                  velocity: const Velocity(pixelsPerSecond: Offset(25, 0)),
                  mode: TextScrollMode.endless,
                  delayBefore: const Duration(seconds: 1),
                  pauseBetween: const Duration(seconds: 3),
                  style: typography.display.lg.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  song.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: typography.body.sm.copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PlayerSeekBar(song: song, playbackController: playbackController),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 56,
                child: state.canGoPrevious
                    ? FButton.icon(
                        variant: .ghost,
                        onPress: playbackController.previous,
                        child: const Icon(FLucideIcons.skipBack, size: 24),
                      )
                    : null,
              ),
              FButton.icon(
                variant: .primary,
                onPress: playbackController.togglePlayPause,
                child: state.loading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: FCircularProgress(),
                      )
                    : Icon(
                        state.playing ? FLucideIcons.pause : FLucideIcons.play,
                        size: 28,
                      ),
              ),
              SizedBox(
                width: 56,
                child: state.canGoNext
                    ? FButton.icon(
                        variant: .ghost,
                        onPress: playbackController.next,
                        child: const Icon(FLucideIcons.skipForward, size: 24),
                      )
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
