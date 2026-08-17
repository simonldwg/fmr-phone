import 'package:fitness_music_recommender/features/library/domain/models/song.dart';

abstract interface class PlaybackSource {
  Future<Song> getCurrentSong();
  Future<Song> next();
  Future<Song> previous();
  bool canGoNext();
  bool canGoPrevious();
}
