import 'filters.dart';
import 'fmr_settings.dart';

class SettingsDefaults {
  SettingsDefaults._();

  static FMRSettings buildFromOnboarding({
    required String apiUrl,
    required int targetHrModerate,
    required int targetHrVigorous,
  }) {
    return FMRSettings(
      apiUrl,
      false, // useBasicExerciseScreen
      targetHrModerate,
      targetHrVigorous,
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
      131, // initialBpmModerate
      136, // initialBpmVigorous
    );
  }
}
