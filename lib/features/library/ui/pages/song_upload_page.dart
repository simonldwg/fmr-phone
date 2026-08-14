import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/library_providers.dart';
import '../../domain/models/album_short.dart';
import '../widgets/album_upload_section.dart';

class SongUploadPage extends ConsumerStatefulWidget {
  const SongUploadPage({super.key});

  @override
  ConsumerState<SongUploadPage> createState() => _SongUploadPageState();
}

class _SongUploadPageState extends ConsumerState<SongUploadPage> {
  final _key = GlobalKey<FormState>();

  AlbumMode _albumMode = AlbumMode.newAlbum;

  String _albumName = '';
  String _albumArtist = '';
  String _songTitle = '';
  String _songArtist = '';

  File? _artworkFile;
  PlatformFile? _audioFile;
  bool _audioFileError = false;

  AlbumShort? _selectedExistingAlbum;
  bool _existingAlbumError = false;

  bool _isSubmitting = false;

  bool get _isNewAlbumMode => _albumMode == AlbumMode.newAlbum;

  Future<void> _pickArtwork() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() => _artworkFile = File(picked.path));
  }

  Future<void> _pickAudio() async {
    final result = await FilePicker.pickFiles(type: FileType.audio);
    final file = result?.files.singleOrNull;
    if (file == null) return;
    setState(() {
      _audioFile = file;
      _audioFileError = false;
    });
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    final formValid = _key.currentState!.validate();
    final audioSelected = _audioFile != null;
    final existingAlbumSelected =
        _isNewAlbumMode || _selectedExistingAlbum != null;

    setState(() {
      _audioFileError = !audioSelected;
      _existingAlbumError = !_isNewAlbumMode && _selectedExistingAlbum == null;
    });

    if (!formValid || !audioSelected || !existingAlbumSelected) return;

    _key.currentState!.save();
    setState(() => _isSubmitting = true);

    final repository = ref.read(libraryRepositoryProvider);

    try {
      final AlbumShort album;
      if (_isNewAlbumMode) {
        album = await repository.createAlbum(
          albumName: _albumName,
          artist: _albumArtist,
          artworkFile: _artworkFile,
        );
      } else {
        album = _selectedExistingAlbum!;
      }

      await repository.createSong(
        title: _songTitle,
        artist: _songArtist,
        audioFile: File(_audioFile!.path!),
        albumId: album.id,
      );

      ref.invalidate(allAlbumsProvider);
      ref.invalidate(albumProvider(album.id));

      if (!mounted) return;
      showFToast(
        context: context,
        icon: const Icon(FLucideIcons.circleCheck),
        title: const Text('Song hochgeladen'),
        description: Text(
          '"$_songTitle" wurde zu "${album.albumName}" hinzugefügt.',
        ),
      );
      context.go('/library/albums/${album.id}');
    } on DioException catch (e) {
      if (!mounted) return;
      showFToast(
        context: context,
        variant: .destructive,
        icon: const Icon(FLucideIcons.circleX),
        title: const Text('Upload fehlgeschlagen'),
        description: Text('Bitte versuche es erneut: ${e.message}'),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String? _validateRequiredForNewAlbum(String? value) {
    if (!_isNewAlbumMode) return null;
    return _validateRequired(value);
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Pflichtfeld.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colors = context.theme.colors;
    final existingAlbums = ref.watch(allAlbumsProvider);

    return PopScope(
      canPop: !_isSubmitting,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        showFToast(
          context: context,
          icon: const Icon(FLucideIcons.info),
          title: const Text('Bitte warten'),
          description: const Text('Der Song wird noch hochgeladen.'),
        );
      },
      child: FScaffold(
        resizeToAvoidBottomInset: false,
        header: FHeader.nested(
          titleAlignment: .centerLeft,
          prefixes: [
            FHeaderAction.back(
              onPress: _isSubmitting ? null : () => context.pop(),
            ),
          ],
          title: const Text('Song hochladen'),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
          ),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AlbumUploadSection(
                  mode: _albumMode,
                  onModeChanged: (mode) => setState(() => _albumMode = mode),
                  artworkFile: _artworkFile,
                  onPickArtwork: _pickArtwork,
                  albumNameValidator: _validateRequiredForNewAlbum,
                  albumArtistValidator: _validateRequiredForNewAlbum,
                  onAlbumNameSaved: (value) => _albumName = value!.trim(),
                  onAlbumArtistSaved: (value) => _albumArtist = value!.trim(),
                  existingAlbums: existingAlbums,
                  selectedExistingAlbum: _selectedExistingAlbum,
                  onExistingAlbumChanged: (album) => setState(() {
                    _selectedExistingAlbum = album;
                    _existingAlbumError = false;
                  }),
                  existingAlbumError: _existingAlbumError,
                ),
                const SizedBox(height: 16),
                FCard(
                  builder: (context, style, _) => Padding(
                    padding: style.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Song',
                          style: typography.body.sm.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.foreground,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FTextFormField(
                          control: .managed(),
                          label: const Text('Titel'),
                          hint: 'z.B. Come Together',
                          autovalidateMode: .onUserInteraction,
                          validator: _validateRequired,
                          onSaved: (value) => _songTitle = value!.trim(),
                        ),
                        const SizedBox(height: 16),
                        FTextFormField(
                          control: .managed(),
                          label: const Text('Künstler'),
                          hint: 'z.B. The Beatles',
                          autovalidateMode: .onUserInteraction,
                          validator: _validateRequired,
                          onSaved: (value) => _songArtist = value!.trim(),
                        ),
                        const SizedBox(height: 16),
                        _AudioPicker(
                          file: _audioFile,
                          onPick: _pickAudio,
                          showError: _audioFileError,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: .end,
                  children: [
                    FButton(
                      onPress: _isSubmitting ? null : _submit,
                      prefix: _isSubmitting
                          ? const FCircularProgress(size: .sm)
                          : const Icon(FLucideIcons.upload),
                      child: Text(
                        _isSubmitting
                            ? 'Wird hochgeladen...'
                            : 'Song hochladen',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AudioPicker extends StatelessWidget {
  const _AudioPicker({
    required this.file,
    required this.onPick,
    required this.showError,
  });
  final PlatformFile? file;
  final VoidCallback onPick;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FItem(
          style: .delta(
            backgroundColor: .delta([.base(context.theme.colors.card)]),
            contentDecoration: .delta([
              .base(.boxDelta(color: context.theme.colors.card)),
            ]),
          ),
          prefix: Icon(
            FLucideIcons.music,
            color: showError ? colors.destructive : null,
          ),
          title: Text(file == null ? 'Audiodatei auswählen' : file!.name),
          subtitle: file == null
              ? const Text('Erforderlich')
              : const Text('Zum Ändern erneut antippen'),
          onPress: onPick,
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              'Bitte wähle eine Audiodatei aus.',
              style: context.theme.typography.body.xs.copyWith(
                color: colors.destructive,
              ),
            ),
          ),
      ],
    );
  }
}
