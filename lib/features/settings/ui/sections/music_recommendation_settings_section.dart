import 'package:flutter/widgets.dart';

import 'music/initial_values_settings.dart';
import 'music/filter_settings.dart';
import 'music/song_selection_settings.dart';
import 'music/weight_settings.dart';
import '../widgets/settings_section_title.dart';

class MusicRecommendationSettingsSection extends StatelessWidget {
  const MusicRecommendationSettingsSection({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SettingsSectionTitle('Musikempfehlung'),
      WeightSettings(),
      SizedBox(height: 24),
      FilterSettings(),
      SizedBox(height: 24),
      SongSelectionSettings(),
      SizedBox(height: 24),
      InitialValuesSettings(),
    ],
  );
}
