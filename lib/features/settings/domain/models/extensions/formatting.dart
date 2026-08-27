import 'package:fitness_music_recommender/features/library/domain/models/genre.dart';
import 'package:fitness_music_recommender/features/common/utils/duration_formatting.dart';

import '../../../../recommendation/domain/models/filters.dart';

extension LengthFilterFormatting on LengthFilter {
  String get statusLabel {
    if (!enabled) return 'Aus';
    return formatDurationFromSeconds(seconds);
  }
}

extension GenreFilterFormatting on Set<Genre> {
  String get statusLabel => isEmpty ? 'Aus' : map((g) => g.label).join(', ');
}
