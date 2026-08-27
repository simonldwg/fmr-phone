import 'package:collection/collection.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/song_selection_strategy.dart';

import '../../library/domain/models/song.dart';
import 'models/recommendation.dart';

class SongSelector {
  Set<Song> _alreadyPlayed = {};
  final SongSelectionStrategy strategy;
  final bool allowMultiplePlays;

  SongSelector({required this.strategy, required this.allowMultiplePlays});

  Song selectSong(Recommendation recommendation) {
    final songs = _filterIfNecessary(recommendation.playlist);

    final selected = switch (strategy) {
      SongSelectionStrategy.shortest => _getShortest(songs),
      SongSelectionStrategy.median => _getMedian(songs),
      SongSelectionStrategy.bestMatch => songs[0],
    };

    _alreadyPlayed.add(selected);
    return selected;
  }

  Song selectRandomSong(Recommendation recommendation) {
    final songs = _filterIfNecessary(recommendation.playlist);
    return songs.sample(1)[0];
  }

  static void _sortByLength(List<Song> songs) {
    songs.sort((a, b) => a.durationS.compareTo(b.durationS));
  }

  static Song _getShortest(List<Song> songs) {
    _sortByLength(songs);
    return songs[0];
  }

  static Song _getMedian(List<Song> songs) {
    int medianIndex = songs.length ~/ 2;
    _sortByLength(songs);
    return songs[medianIndex];
  }

  List<Song> _filterIfNecessary(List<Song> playlist) {
    if (allowMultiplePlays) {
      return List<Song>.from(playlist);
    }

    List<Song> filtered = playlist
        .where((song) => !_alreadyPlayed.contains(song))
        .toList();

    // if the filtered list is empty, i.e. all songs have already been played,
    // return the entire playlist and clear the already played songs.
    if (filtered.isEmpty) {
      _alreadyPlayed = {};
      return playlist;
    }

    return filtered;
  }
}
