import 'package:fitness_music_recommender/features/library/domain/models/album.dart';
import 'package:fitness_music_recommender/features/playback/domain/controllers/playback_controller.dart';

import '../sources/playlist_source.dart';

class LibraryPlaybackController extends PlaybackController {
  LibraryPlaybackController(super.handler, super.session);

  Future<void> playAlbum(Album album) async {
    if (album.songs.isEmpty) return;
    if (!session.activateLibrary()) return;
    handler.setSource(PlaylistSource(album.songs));
    await handler.startPlayingFromCurrentPosition();
  }

  Future<void> playAlbumFrom(Album album, int startSongIndex) async {
    if (album.songs.isEmpty || album.songs.length <= startSongIndex) return;
    if (!session.activateLibrary()) return;
    handler.setSource(PlaylistSource(album.songs, startAt: startSongIndex));
    await handler.startPlayingFromCurrentPosition();
  }
}
