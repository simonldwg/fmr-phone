import 'package:fitness_music_recommender/features/common/utils/duration_formatting.dart';

import '../song.dart';

extension SongFormatting on Song {
  String get durationString => formatDurationFromSeconds(durationS);
}
