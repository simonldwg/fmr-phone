import 'package:audio_service/audio_service.dart';
import '../../../../library/domain/models/song.dart';

extension SongMediaItem on Song {
  MediaItem toMediaItem() => MediaItem(
    id: id,
    title: title,
    artist: artist,
    album: album.albumName,
    duration: Duration(microseconds: (durationS * 1e6).round()),
    artUri: album.artworkUrl != null ? Uri.parse(album.artworkUrl!) : null,
    extras: {'url': songUrl},
  );
}
