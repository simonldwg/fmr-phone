import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../domain/models/album_short.dart';
import 'artwork_image.dart';

enum AlbumMode { newAlbum, existingAlbum }

/// form for selecting / creating an album while uploading a song
class AlbumUploadSection extends StatelessWidget {
  const AlbumUploadSection({
    required this.mode,
    required this.onModeChanged,
    required this.artworkFile,
    required this.onPickArtwork,
    required this.albumNameValidator,
    required this.albumArtistValidator,
    required this.onAlbumNameSaved,
    required this.onAlbumArtistSaved,
    required this.existingAlbums,
    required this.selectedExistingAlbum,
    required this.onExistingAlbumChanged,
    required this.existingAlbumError,
    super.key,
  });

  final AlbumMode mode;
  final ValueChanged<AlbumMode> onModeChanged;

  final File? artworkFile;
  final VoidCallback onPickArtwork;
  final FormFieldValidator<String> albumNameValidator;
  final FormFieldValidator<String> albumArtistValidator;
  final FormFieldSetter<String> onAlbumNameSaved;
  final FormFieldSetter<String> onAlbumArtistSaved;

  final AsyncValue<List<AlbumShort>> existingAlbums;
  final AlbumShort? selectedExistingAlbum;
  final ValueChanged<AlbumShort?> onExistingAlbumChanged;
  final bool existingAlbumError;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        FTabs(
          onPress: (index) => onModeChanged(AlbumMode.values[index]),
          children: [
            .entry(
              label: const Text('Neues Album'),
              child: FCard(
                builder: (context, style, _) => Padding(
                  padding: style.padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FTextFormField(
                        control: .managed(),
                        label: const Text('Albumname'),
                        hint: 'z.B. Abbey Road',
                        autovalidateMode: .onUserInteraction,
                        validator: albumNameValidator,
                        onSaved: onAlbumNameSaved,
                      ),
                      const SizedBox(height: 16),
                      FTextFormField(
                        control: .managed(),
                        label: const Text('Künstler'),
                        hint: 'z.B. The Beatles',
                        autovalidateMode: .onUserInteraction,
                        validator: albumArtistValidator,
                        onSaved: onAlbumArtistSaved,
                      ),
                      const SizedBox(height: 16),
                      _ArtworkPicker(file: artworkFile, onPick: onPickArtwork),
                    ],
                  ),
                ),
              ),
            ),
            .entry(
              label: const Text('Bestehendes Album'),
              child: FCard(
                builder: (context, style, _) => Padding(
                  padding: style.padding,
                  child: existingAlbums.when(
                    loading: () => Center(child: FCircularProgress(size: .sm)),
                    error: (error, _) => Text(
                      'Alben konnten nicht geladen werden.',
                      style: style.subtitleTextStyle,
                    ),
                    data: (albums) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wähle ein bestehendes Album aus der Liste aus.',
                          style: style.subtitleTextStyle,
                        ),
                        const SizedBox(height: 16),
                        FSelect<AlbumShort>.searchBuilder(
                          hint: 'Album suchen',
                          control: .managed(
                            initial: selectedExistingAlbum,
                            onChange: onExistingAlbumChanged,
                          ),
                          format: (album) =>
                              '${album.artist} - ${album.albumName}',
                          filter: (query) {
                            final normalized = query.toLowerCase();
                            return albums.where(
                              (album) => '${album.artist} - ${album.albumName}'
                                  .toLowerCase()
                                  .contains(normalized),
                            );
                          },
                          contentBuilder: (context, _, matches) => [
                            for (final album in matches)
                              .item(
                                title: Text(
                                  '${album.artist} - ${album.albumName}',
                                ),
                                value: album,
                              ),
                          ],
                        ),
                        if (existingAlbumError)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Text(
                              'Bitte wähle ein Album aus.',
                              style: typography.body.xs.copyWith(
                                color: colors.destructive,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ArtworkPicker extends StatelessWidget {
  const _ArtworkPicker({required this.file, required this.onPick});
  final File? file;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return FItem(
      style: .delta(
        backgroundColor: .delta([.base(context.theme.colors.card)]),
        contentDecoration: .delta([
          .base(.boxDelta(color: context.theme.colors.card)),
        ]),
      ),
      prefix: SizedBox(
        width: 48,
        height: 48,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: file != null
              ? Image.file(file!, fit: BoxFit.cover)
              : const ArtworkImage(url: null, iconSize: 24),
        ),
      ),
      title: Text(
        file == null ? 'Artwork auswählen (optional)' : 'Artwork ausgewählt',
      ),
      subtitle: file == null ? null : const Text('Zum Ändern erneut antippen'),
      onPress: onPick,
    );
  }
}
