import 'package:fitness_music_recommender/features/library/domain/models/song.dart';

import '../album_short.dart';

String _resolveUrl(String baseUrl, String path) {
  if (path.isEmpty) return path;

  final uri = Uri.tryParse(path);
  if (uri == null) return path;
  if (uri.hasScheme) return path;

  final base = Uri.tryParse(baseUrl);
  if (base == null) return path;

  return base.resolve(path).toString();
}

extension AlbumUrlResolver on AlbumShort {
  void resolveUrls(String baseUrl) {
    final url = artworkUrl;
    if (url != null && url.isNotEmpty) {
      artworkUrl = _resolveUrl(baseUrl, url);
    }
  }
}

extension SongUrlResolver on Song {
  void resolveUrls(String baseUrl) {
    songUrl = _resolveUrl(baseUrl, songUrl);
    album.resolveUrls(baseUrl);
  }
}
