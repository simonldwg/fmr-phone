import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../common/ui/widgets/confirmation_dialog.dart';
import '../../data/library_providers.dart';
import '../../domain/models/album_short.dart';
import '../../domain/models/song.dart';

Future<void> confirmAndDeleteSong(
  BuildContext context,
  WidgetRef ref,
  Song song,
) async {
  final confirmed = await showConfirmDialog(
    context,
    title: 'Song löschen',
    message:
        '"${song.title}" von ${song.artist} wird dauerhaft gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.',
    confirmText: 'Löschen',
    destructive: true,
  );

  if (!confirmed) return;

  try {
    await ref.read(libraryRepositoryProvider).deleteSong(song.id);
    ref.invalidate(albumProvider(song.album.id));
    if (context.mounted) {
      showFToast(
        context: context,
        icon: const Icon(FLucideIcons.trash2),
        title: Text('Song gelöscht'),
        description: Text(
          'Song "${song.title}" von ${song.artist} wurde gelöscht.',
        ),
      );

      // go to the album page, but only if we're not already there
      final albumLocation = '/library/albums/${song.album.id}';
      final currentLocation = GoRouterState.of(context).uri.path;
      if (currentLocation != albumLocation) {
        context.go(albumLocation);
      }
    }
  } on DioException catch (e) {
    if (!context.mounted) return;
    showFToast(
      context: context,
      variant: .destructive,
      icon: const Icon(FLucideIcons.circleX),
      title: Text('Song konnte nicht gelöscht werden'),
      description: Text('Bitte versuche es erneut: ${e.message}'),
    );
  }
}

Future<void> confirmAndDeleteAlbum(
  BuildContext context,
  WidgetRef ref,
  AlbumShort album,
) async {
  final confirmed = await showConfirmDialog(
    context,
    title: 'Album löschen',
    message:
        '"${album.albumName}" von ${album.artist} wird inklusive aller enthaltenen Songs dauerhaft gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.',
    confirmText: 'Löschen',
    destructive: true,
  );

  if (!confirmed) return;

  try {
    await ref.read(libraryRepositoryProvider).deleteAlbum(album.id);
    ref.invalidate(allAlbumsProvider);
    if (context.mounted) {
      showFToast(
        context: context,
        icon: const Icon(FLucideIcons.trash2),
        title: Text('Album gelöscht'),
        description: Text(
          'Album "${album.albumName}" von ${album.artist} wurde gelöscht.',
        ),
      );
      context.go('/library');
    }
  } on DioException catch (e) {
    if (!context.mounted) return;
    showFToast(
      context: context,
      variant: .destructive,
      icon: const Icon(FLucideIcons.circleX),
      title: Text('Album konnte nicht gelöscht werden'),
      description: Text('Bitte versuche es erneut: ${e.message}'),
    );
  }
}
