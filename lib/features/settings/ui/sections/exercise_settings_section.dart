import 'package:fitness_music_recommender/features/common/ui/widgets/small_description_text.dart';
import 'package:fitness_music_recommender/features/exercise/domain/models/exercise_intensity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../data/settings_controller_provider.dart';
import '../widgets/edit_number_value_sheet.dart';
import '../../../common/ui/widgets/section_title.dart';

class ExerciseSettingsSection extends ConsumerWidget {
  const ExerciseSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FTheme.of(context);

    final controller = ref.watch(settingsControllerProvider);
    final settings = controller.requireSettings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Trainingseinstellungen'),
        Row(
          children: [
            Expanded(
              child: Text(
                'Einfacher Trainingsbildschirm (Uhr)',
                style: theme.typography.body.xs,
              ),
            ),
            FSwitch(
              value: settings.useBasicExerciseScreen,
              onChange: (value) => ref
                  .read(settingsControllerProvider)
                  .updateWith(useBasicExerciseScreen: value),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const SmallDescriptionText(
          'Wenn aktiviert, wird während des Trainings in der Smartwatch-App nur ein großer Button zum Überspringen des aktuellen Songs angezeigt.',
        ),
        const SizedBox(height: 24),
        FTileGroup(
          label: const Text('Ziel-Herzfrequenzen'),
          children: [
            .tile(
              prefix: const Icon(FLucideIcons.heartPulse),
              title: const Text('Moderates Training'),
              details: Text(
                '${settings.heartRateFor(ExerciseIntensity.moderate)}',
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showEditNumberValueSheet(
                context: context,
                title: 'Moderates Training',
                description:
                    'Lege die Ziel-Herzfrequenz für moderates Training fest.',
                initialValue: settings.heartRateFor(ExerciseIntensity.moderate),
                onSave: (value) => ref
                    .read(settingsControllerProvider)
                    .updateTargetHeartRate(ExerciseIntensity.moderate, value),
                label: 'Herzfrequenz',
                hint: 'z.B. 139',
                min: 80,
                max: 200,
              ),
            ),
            .tile(
              prefix: const Icon(FLucideIcons.heartPulse),
              title: const Text('Starkes Training'),
              details: Text(
                '${settings.heartRateFor(ExerciseIntensity.vigorous)}',
              ),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showEditNumberValueSheet(
                context: context,
                title: 'Starkes Training',
                description:
                    'Lege die Ziel-Herzfrequenz für starkes Training fest.',
                initialValue: settings.heartRateFor(ExerciseIntensity.vigorous),
                onSave: (value) => ref
                    .read(settingsControllerProvider)
                    .updateTargetHeartRate(ExerciseIntensity.vigorous, value),
                label: 'Herzfrequenz',
                hint: 'z.B. 147',
                min: 80,
                max: 200,
              ),
            ),
            .tile(
              prefix: const Icon(FLucideIcons.heartPulse),
              title: Text('Ziel-Herzfrequenzen neu berechnen'),
              onPress: () => context.push('/settings/calculate-hr'),
              suffix: const Icon(FLucideIcons.chevronRight),
            ),
          ],
        ),
      ],
    );
  }
}
