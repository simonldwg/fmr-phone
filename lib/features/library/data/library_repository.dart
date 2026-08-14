import 'dart:io';

import '../../common/utils/url_resolver.dart';

import '../domain/models/album.dart';
import '../domain/models/album_short.dart';
import '../domain/models/song.dart';
import 'remote/library_api_client.dart';

class LibraryRepository {
  LibraryRepository(this._client, this._baseUrl);

  final LibraryApiClient _client;
  final String _baseUrl;

  Future<AlbumShort> createAlbum({
    required String albumName,
    required String artist,
    File? artworkFile,
  }) async {
    final album = await _client.createAlbum(albumName, artist, artworkFile);
    return _withResolvedArtwork(album);
  }

  Future<List<AlbumShort>> getAllAlbums() async {
    final albums = await _client.getAllAlbums();
    return albums.map(_withResolvedArtwork<AlbumShort>).toList();
  }

  Future<Album> getAlbum(String albumId) async {
    final album = await _client.getAlbum(albumId);
    _withResolvedArtwork(album);
    for (final song in album.songs) {
      _withResolvedSongUrl(song);
    }
    return album;
  }

  Future<void> deleteAlbum(String albumId) => _client.deleteAlbum(albumId);

  Future<Song> createSong({
    required String title,
    required String artist,
    required File audioFile,
    required String albumId,
  }) async {
    final song = await _client.createSong(title, artist, audioFile, albumId);
    return _withResolvedSongUrl(song);
  }

  Future<void> deleteSong(String songId) => _client.deleteSong(songId);

  T _withResolvedArtwork<T extends AlbumShort>(T album) {
    final url = album.artworkUrl;
    if (url != null && url.isNotEmpty) {
      album.artworkUrl = resolveUrl(_baseUrl, url);
    }
    return album;
  }

  Song _withResolvedSongUrl(Song song) {
    song.songUrl = resolveUrl(_baseUrl, song.songUrl);

    final artworkUrl = song.artworkUrl;
    if (artworkUrl != null && artworkUrl.isNotEmpty) {
      song.artworkUrl = resolveUrl(_baseUrl, artworkUrl);
    }

    _withResolvedArtwork(song.album);

    return song;
  }
}
