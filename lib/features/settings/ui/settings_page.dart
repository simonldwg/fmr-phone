import 'sections/backend_settings_section.dart';
import 'sections/exercise_settings_section.dart';
import 'sections/music_recommendation_settings_section.dart';
import 'sections/reset_settings_section.dart';
import 'sections/troubleshooting_section.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => FScaffold(
    resizeToAvoidBottomInset: false,
    header: const FHeader(title: Text('Einstellungen')),
    child: SingleChildScrollView(
      padding: EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          BackendSettingsSection(),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          ExerciseSettingsSection(),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          MusicRecommendationSettingsSection(),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          TroubleshootingSection(),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          ResetSettingsSection(),
        ],
      ),
    ),
  );
}
