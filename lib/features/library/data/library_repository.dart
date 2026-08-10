import '../../common/utils/url_resolver.dart';
import '../domain/models/album_short.dart';
import 'remote/library_api_client.dart';

class LibraryRepository {
  LibraryRepository(this._client, this._baseUrl);

  final LibraryApiClient _client;
  final String _baseUrl;

  Future<List<AlbumShort>> getAllAlbums() async {
    final albums = await _client.getAllAlbums();
    return albums.map(_withResolvedArtwork).toList();
  }

  AlbumShort _withResolvedArtwork(AlbumShort album) {
    if (album.artworkUrl != null) {
      album.artworkUrl = resolveUrl(_baseUrl, album.artworkUrl!);
    }
    return album;
  }
}
