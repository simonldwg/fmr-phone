import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../common/ui/widgets/ellipse_menu.dart';
import '../../../common/ui/widgets/error_screen.dart';
import '../../data/library_providers.dart';
import '../../domain/models/album.dart';
import '../actions/delete_actions.dart';
import '../widgets/album_hero.dart';
import '../widgets/song_tile.dart';

class AlbumDetailPage extends ConsumerWidget {
  const AlbumDetailPage({required this.albumId, super.key});
  final String albumId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumAsync = ref.watch(albumProvider(albumId));

    return FScaffold(
      childPad: false,
      child: Stack(
        children: [
          albumAsync.when(
            skipLoadingOnRefresh: false,
            loading: () => const Center(child: FCircularProgress(size: .xl)),
            error: (error, _) => Center(
              child: ErrorScreen(
                title: 'Fehler',
                description:
                    'Album konnte nicht geladen werden. Bitte überprüfe deine API-URL in den Einstellungen.',
                onPress: () => ref.invalidate(albumProvider(albumId)),
              ),
            ),
            data: (album) => _AlbumBody(album: album),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FButton.icon(
                variant: .ghost,
                size: .lg,
                onPress: () => context.pop(),
                child: const Icon(FLucideIcons.arrowLeft),
              ),
            ),
          ),
          albumAsync.maybeWhen(
            data: (album) => SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: EllipseMenu(
                    buttonSize: .lg,
                    menu: [
                      .group(
                        children: [
                          .item(
                            variant: .destructive,
                            prefix: const Icon(FLucideIcons.trash2),
                            title: const Text('Album löschen'),
                            onPress: () =>
                                confirmAndDeleteAlbum(context, ref, album),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _AlbumBody extends ConsumerWidget {
  const _AlbumBody({required this.album});
  final Album album;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.theme.colors;
    final topPadding = MediaQuery.paddingOf(context).top + 72;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AlbumHero(album: album, topPadding: topPadding),
        Container(color: colors.background, height: 24),
        (album.songs.isEmpty)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text('Dieses Album hat (noch) keine Songs.'),
                ),
              )
            : FItemGroup(
                children: [
                  for (final song in album.songs)
                    songTile(
                      song,
                      onDelete: () => confirmAndDeleteSong(context, ref, song),
                      onShowDetails: () =>
                          context.push('/library/song', extra: song),
                    ),
                ],
              ),
        const SizedBox(height: 16),
      ],
    );
  }
}
