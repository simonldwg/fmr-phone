import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/album.dart';
import '../../domain/models/album_short.dart';
import '../../domain/models/song.dart';

part 'library_api_client.g.dart';

@RestApi(baseUrl: '/library')
abstract class LibraryApiClient {
  factory LibraryApiClient(Dio dio, {String? baseUrl}) = _LibraryApiClient;

  @POST('/albums/')
  @MultiPart()
  Future<AlbumShort> createAlbum(
    @Part(name: 'album_name') String albumName,
    @Part(name: 'artist') String artist,
    @Part(name: 'artwork_file') File? artworkFile,
  );

  @GET('/albums/all')
  Future<List<AlbumShort>> getAllAlbums();

  @GET('/albums/{albumId}')
  Future<Album> getAlbum(@Path('albumId') String albumId);

  @DELETE('/albums/{albumId}')
  Future<void> deleteAlbum(@Path('albumId') String albumId);

  @POST('/songs/')
  @MultiPart()
  Future<Song> createSong(
    @Part(name: 'title') String title,
    @Part(name: 'artist') String artist,
    @Part(name: 'audio_file') File audioFile,
    @Part(name: 'album_id') String albumId,
  );

  @DELETE('/songs/{songId}')
  Future<void> deleteSong(@Path('songId') String songId);
}
