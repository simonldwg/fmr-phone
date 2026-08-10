import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/album_short.dart';

part 'library_api_client.g.dart';

@RestApi(baseUrl: '/library')
abstract class LibraryApiClient {
  factory LibraryApiClient(Dio dio, {String? baseUrl}) = _LibraryApiClient;

  @GET('/albums/all')
  Future<List<AlbumShort>> getAllAlbums();
}
