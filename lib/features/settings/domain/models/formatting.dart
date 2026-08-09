import 'package:fitness_music_recommender/features/common/domain/models/genre.dart';

import 'fmr_settings.dart';

extension LengthFilterFormatting on LengthFilter {
  String get statusLabel {
    if (!enabled) return 'Aus';
    final duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutesString = twoDigits(duration.inMinutes.remainder(60).abs());
    String secondsString = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$minutesString:$secondsString";
  }
}

extension GenreFilterFormatting on Set<Genre> {
  String get statusLabel => isEmpty ? 'Aus' : map((g) => g.label).join(', ');
}
