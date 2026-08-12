import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../common/ui/widgets/ellipse_menu.dart';
import '../../domain/models/formatting.dart';
import '../../domain/models/genre.dart';
import '../../domain/models/song.dart';
import '../actions/delete_actions.dart';
import '../widgets/artwork_image.dart';

class SongDetailPage extends ConsumerWidget {
  const SongDetailPage({required this.song, super.key});
  final Song song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return FScaffold(
      header: FHeader.nested(
        prefixes: [FHeaderAction.back(onPress: () => context.pop())],
        title: const Text('Songdetails'),
        titleAlignment: .centerLeft,
        suffixes: [
          EllipseMenu(
            buttonSize: .md,
            menu: [
              .group(
                children: [
                  .item(
                    variant: .destructive,
                    prefix: const Icon(FLucideIcons.trash2),
                    title: const Text('Song löschen'),
                    onPress: () => confirmAndDeleteSong(context, ref, song),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: SizedBox(
              width: 180,
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ArtworkImage(
                  url: song.artworkUrl ?? song.album.artworkUrl,
                  iconSize: 56,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            song.title,
            textAlign: TextAlign.center,
            style: typography.display.md.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.foreground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            song.artist,
            textAlign: TextAlign.center,
            style: typography.body.sm.copyWith(color: colors.mutedForeground),
          ),
          const SizedBox(height: 24),
          FItemGroup(
            children: [
              FItem(
                prefix: const Icon(FLucideIcons.disc),
                title: Text(song.album.albumName),
                subtitle: const Text('Album'),
                suffix: const Icon(FLucideIcons.chevronRight),
                onPress: () => context.push('/library/albums/${song.album.id}'),
              ),
              FItem(
                prefix: const Icon(FLucideIcons.clock),
                title: Text(song.durationString),
                subtitle: const Text('Dauer'),
              ),
              FItem(
                prefix: const Icon(FLucideIcons.gauge),
                title: Text('${song.features.bpm.round()} BPM'),
                subtitle: const Text('Tempo'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Features',
            style: typography.body.sm.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Arousal: ${song.features.arousal}',
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          Text(
            'Valence: ${song.features.valence}',
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          Text(
            'Authenticity: ${song.features.authenticity}',
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          Text(
            'Timeliness: ${song.features.timeliness}',
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          Text(
            'Complexity: ${song.features.complexity}',
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          Text(
            'Danceability: ${song.features.danceability}',
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          Text(
            'Tonal: ${song.features.tonal}',
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          Text(
            'Voice: ${song.features.voice}',
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          const SizedBox(height: 24),
          Text(
            'Top-Genres',
            style: typography.body.sm.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _GenreChips(genres: song.genres.top3Genres, highlighted: true),
          const SizedBox(height: 24),
          Text(
            'Alle Genres',
            style: typography.body.sm.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _GenreChips(genres: song.genres.allGenres, highlighted: false),
        ],
      ),
    );
  }
}

class _GenreChips extends StatelessWidget {
  const _GenreChips({required this.genres, required this.highlighted});
  final Map<Genre, double> genres;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final sorted = genres.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final entry in sorted)
          FBadge(
            variant: highlighted ? .primary : .secondary,
            child: Text('${entry.key.label} (${entry.value})'),
          ),
      ],
    );
  }
}
