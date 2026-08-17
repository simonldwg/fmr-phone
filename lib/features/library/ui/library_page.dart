import 'package:fitness_music_recommender/features/library/domain/models/album_short.dart';
import 'package:fitness_music_recommender/features/library/domain/models/song.dart';
import 'package:fitness_music_recommender/features/library/ui/widgets/artwork_image.dart';
import 'package:fitness_music_recommender/features/library/ui/widgets/pulsing_play_icon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../common/ui/widgets/error_screen.dart';
import '../../playback/playback_providers.dart';
import '../data/library_providers.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(allAlbumsProvider);
    final currentSong = ref.watch(currentSongProvider);

    return FScaffold(
      header: FHeader(
        title: const Text('Bibliothek'),
        suffixes: [
          FHeaderAction(
            icon: const Icon(FLucideIcons.plus),
            onPress: () => context.push('/library/songs/upload'),
          ),
        ],
      ),
      childPad: false,
      child: albumsAsync.when(
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: FCircularProgress(size: .xl)),
        error: (error, _) => Center(
          child: ErrorScreen(
            title: 'Fehler',
            description:
                'Alben konnte nicht geladen werden. Bitte überprüfe deine API-URL in den Einstellungen.',
            onPress: () => ref.invalidate(allAlbumsProvider),
          ),
        ),
        data: (albums) => _AlbumGrid(albums: albums, currentSong: currentSong),
      ),
    );
  }
}

class _AlbumGrid extends StatelessWidget {
  const _AlbumGrid({required this.albums, required this.currentSong});
  final List<AlbumShort> albums;
  final Song? currentSong;

  @override
  Widget build(BuildContext context) {
    if (albums.isEmpty) {
      return const Center(child: Text('Keine Alben gefunden.'));
    }

    return AlignedGridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 16,
      itemCount: albums.length,
      itemBuilder: (context, index) => _AlbumGridTile(
        album: albums[index],
        isPlaying: albums[index] == currentSong?.album,
      ),
    );
  }
}

class _AlbumGridTile extends StatelessWidget {
  const _AlbumGridTile({required this.album, required this.isPlaying});
  final AlbumShort album;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return FTappable(
      onPress: () => context.push('/library/albums/${album.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ArtworkImage(url: album.artworkUrl),
                  // show the play icon above the album if it is currently playing
                  if (isPlaying)
                    Container(
                      color: colors.background.withValues(alpha: 0.6),
                      alignment: Alignment.center,
                      child: PulsingPlayIcon(
                        size: 40,
                        color: colors.foreground,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            album.albumName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: typography.body.sm.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.foreground,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            album.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}
