import 'package:fitness_music_recommender/features/playback/domain/sources/playback_source.dart';
import 'package:fitness_music_recommender/features/library/domain/models/song.dart';
import 'package:fitness_music_recommender/features/playback/domain/sources/playback_source_exception.dart';

class PlaylistSource implements PlaybackSource {
  PlaylistSource(this._playlist, {int startAt = 0}) {
    if (_playlist.isEmpty) {
      throw PlaybackSourceException('Empty playlist provided');
    }
    _index = startAt;
  }

  final List<Song> _playlist;
  int _index = 0;

  @override
  Future<Song> getCurrentSong() async {
    return _playlist[_index];
  }

  @override
  Future<Song> next() async {
    if (_index + 1 < _playlist.length) {
      _index++;
      return _playlist[_index];
    }

    throw PlaybackSourceException('Cannot go next');
  }

  @override
  bool canGoNext() {
    return _index < (_playlist.length - 1);
  }

  @override
  bool canGoPrevious() {
    return _index > 0;
  }

  @override
  Future<Song> previous() async {
    if (_index > 0) {
      _index--;
      return _playlist[_index];
    }

    throw PlaybackSourceException('Cannot go previous');
  }
}
