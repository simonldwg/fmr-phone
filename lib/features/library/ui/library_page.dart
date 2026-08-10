import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_music_recommender/features/common/widgets/error_screen.dart';
import 'package:fitness_music_recommender/features/library/domain/models/album_short.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:forui/forui.dart';
import 'package:shimmer/shimmer.dart';

import '../data/library_providers.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(allAlbumsProvider);

    return FScaffold(
      header: FHeader(
        title: const Text('Musikbibliothek'),
        suffixes: [
          FHeaderAction(icon: const Icon(FLucideIcons.plus), onPress: () {}),
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
        data: (albums) => _AlbumGrid(albums: albums),
      ),
    );
  }
}

class _AlbumGrid extends StatelessWidget {
  const _AlbumGrid({required this.albums});
  final List<AlbumShort> albums;

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
      itemBuilder: (context, index) => _AlbumGridTile(album: albums[index]),
    );
  }
}

class _AlbumGridTile extends StatelessWidget {
  const _AlbumGridTile({required this.album});
  final AlbumShort album;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final artworkUrl = album.artworkUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: (artworkUrl == null || artworkUrl.isEmpty)
                ? _ArtworkPlaceholder(colors: colors)
                : CachedNetworkImage(
                    imageUrl: artworkUrl,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 250),
                    placeholder: (context, url) =>
                        _ArtworkShimmer(color: colors.secondary),
                    errorWidget: (context, url, error) =>
                        _ArtworkPlaceholder(colors: colors),
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
    );
  }
}

/// placeholder for when the album artwork could not be loaded or the album
/// simply has no artwork image
class _ArtworkPlaceholder extends StatelessWidget {
  const _ArtworkPlaceholder({required this.colors});
  final FColors colors;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colors.secondary,
      child: Icon(FLucideIcons.disc, size: 50, color: colors.mutedForeground),
    );
  }
}

/// placeholder for when the album artwork is loading
class _ArtworkShimmer extends StatelessWidget {
  const _ArtworkShimmer({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: color.withValues(alpha: 0.5),
      child: ColoredBox(color: color),
    );
  }
}
