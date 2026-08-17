import 'dart:io';

import 'package:fitness_music_recommender/features/library/domain/models/extensions/url_resolver.dart';

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
    album.resolveUrls(_baseUrl);
    return album;
  }

  Future<List<AlbumShort>> getAllAlbums() async {
    final albums = await _client.getAllAlbums();

    for (final album in albums) {
      album.resolveUrls(_baseUrl);
    }

    return albums;
  }

  Future<Album> getAlbum(String albumId) async {
    final album = await _client.getAlbum(albumId);
    album.resolveUrls(_baseUrl);
    for (final song in album.songs) {
      song.resolveUrls(_baseUrl);
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
    song.resolveUrls(_baseUrl);
    return song;
  }

  Future<void> deleteSong(String songId) => _client.deleteSong(songId);
}
