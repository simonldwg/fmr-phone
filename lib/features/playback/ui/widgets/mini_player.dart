import 'package:fitness_music_recommender/features/playback/domain/controllers/playback_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../library/domain/models/song.dart';
import '../../../library/ui/widgets/artwork_image.dart';
import '../../domain/models/fmr_playback_state.dart';
import '../../playback_providers.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackController = ref.watch(activePlaybackProvider);
    final state =
        ref.watch(playbackStateProvider).valueOrNull ??
        const FMRPlaybackState.idle();

    final song = state.song;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      transitionBuilder: (child, animation) => SizeTransition(
        sizeFactor: animation,
        alignment: AlignmentDirectional(-1, -1),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: (song == null || playbackController == null)
          ? const SizedBox.shrink()
          : _buildMiniPlayer(context, state, song, playbackController),
    );
  }

  Widget _buildMiniPlayer(
    BuildContext context,
    FMRPlaybackState state,
    Song song,
    PlaybackController playbackController,
  ) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    // Process swiping left or right over the mini player (next/previous song)
    void processSwipe(details) {
      final v = details.primaryVelocity ?? 0;
      if (v < 0 && state.canGoNext) {
        playbackController.next();
      } else if (v > 0 && state.canGoPrevious) {
        playbackController.previous();
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              // The GestureDetector is used for detecting swipes (next/previous
              // song), the FTappable is used to redirect users to the album
              // when tapping on the song title/artist/artwork.
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragEnd: processSwipe,
                child: FTappable(
                  onPress: () => context.go('/library/albums/${song.album.id}'),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: ArtworkImage(
                            url: song.album.artworkUrl,
                            iconSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextScroll(
                              song.title,
                              velocity: const Velocity(
                                pixelsPerSecond: Offset(25, 0),
                              ),
                              mode: TextScrollMode.endless,
                              delayBefore: const Duration(seconds: 1),
                              pauseBetween: const Duration(seconds: 3),
                              style: typography.body.sm.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              song.artist,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: typography.body.xs.copyWith(
                                color: colors.mutedForeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            FButton.icon(
              variant: .ghost,
              onPress: state.canGoPrevious ? playbackController.previous : null,
              child: const Icon(FLucideIcons.skipBack),
            ),
            const SizedBox(width: 4),
            FButton.icon(
              variant: .primary,
              onPress: playbackController.togglePlayPause,
              child: state.loading
                  ? FCircularProgress(
                      style: .delta(iconStyle: .delta(color: colors.secondary)),
                    )
                  : Icon(
                      state.playing ? FLucideIcons.pause : FLucideIcons.play,
                    ),
            ),
            const SizedBox(width: 4),
            FButton.icon(
              variant: .ghost,
              onPress: state.canGoNext ? playbackController.next : null,
              child: const Icon(FLucideIcons.skipForward),
            ),
          ],
        ),
      ),
    );
  }
}
