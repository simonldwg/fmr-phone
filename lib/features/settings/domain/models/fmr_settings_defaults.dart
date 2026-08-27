import 'package:fitness_music_recommender/features/exercise/domain/models/exercise_intensity.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/song_selection_strategy.dart';

import '../../../recommendation/domain/models/filters.dart';
import 'fmr_settings.dart';

class SettingsDefaults {
  SettingsDefaults._();

  static FMRSettings buildFromOnboarding({
    required String apiUrl,
    required Map<ExerciseIntensity, int> targetHeartRates,
  }) {
    return FMRSettings(
      apiUrl,
      false, // useBasicExerciseScreen
      targetHeartRates,
      1.0, // arousalWeight
      1.0, // bpmWeight
      Filters(
        const {}, // genres (Set)
        LengthFilter(0, false),
        FeatureFilter(0.0, false),
        FeatureFilter(0.0, false),
        FeatureFilter(0.0, false),
        FeatureFilter(0.0, false),
        FeatureFilter(0.0, false),
        FeatureFilter(0.0, false),
        FeatureFilter(0.0, false),
      ),
      true, // allowMultiplePlays
      SongSelectionStrategy.bestMatch,
      131, // initialBpmModerate
      136, // initialBpmVigorous
    );
  }
}
