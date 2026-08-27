import 'package:fitness_music_recommender/features/common/ui/widgets/ellipse_menu.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'artwork_background.dart';
import 'full_player.dart';
import '../../playback_providers.dart';

class NowPlayingSheet extends ConsumerWidget {
  final double topInset;
  final double bottomInset;

  const NowPlayingSheet({
    required this.topInset,
    required this.bottomInset,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongProvider);
    final colors = context.theme.colors;

    return Stack(
      children: [
        Positioned.fill(
          child: ArtworkBackground(
            artworkUrl: song?.album.artworkUrl,
            fallbackColor: colors.background,
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colors.background.withValues(alpha: 0.1),
                  colors.background.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: topInset + 4),
            child: Row(
              mainAxisSize: .max,
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                FButton.icon(
                  variant: .ghost,
                  onPress: () => Navigator.of(context).pop(),
                  child: const Icon(FLucideIcons.chevronDown),
                ),
                EllipseMenu(
                  menu: [
                    .group(
                      children: [
                        .item(
                          prefix: const Icon(FLucideIcons.info),
                          title: const Text('Songdetails anzeigen'),
                          onPress: () {
                            Navigator.of(context).pop();
                            context.push('/library/song', extra: song);
                          },
                        ),
                        .item(
                          prefix: const Icon(FLucideIcons.discAlbum),
                          title: const Text('Album anzeigen'),
                          onPress: () {
                            Navigator.of(context).pop();
                            context.push('/library/albums/${song?.album.id}');
                          },
                        ),
                      ],
                    ),
                  ],
                  buttonSize: .md,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [const Expanded(child: Center(child: FullPlayer()))],
          ),
        ),
      ],
    );
  }
}
