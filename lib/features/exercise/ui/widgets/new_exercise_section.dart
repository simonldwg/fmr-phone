import 'package:fitness_music_recommender/features/common/ui/widgets/section_title.dart';
import 'package:fitness_music_recommender/features/exercise/domain/controllers/exercise_start_exception.dart';
import 'package:fitness_music_recommender/features/settings/data/settings_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/exercise_intensity.dart';
import '../../exercise_providers.dart';

class NewExerciseSection extends ConsumerStatefulWidget {
  const NewExerciseSection({super.key});

  @override
  ConsumerState<NewExerciseSection> createState() => _NewExerciseSectionState();
}

class _NewExerciseSectionState extends ConsumerState<NewExerciseSection> {
  ExerciseIntensity _selectedIntensity = ExerciseIntensity.moderate;

  late final FMultiValueNotifier<ExerciseIntensity>
  _exerciseIntensityController;

  @override
  void initState() {
    super.initState();

    _exerciseIntensityController = FMultiValueNotifier<ExerciseIntensity>.radio(
      ExerciseIntensity.moderate,
    )..addListener(_onExerciseIntensityChanged);
  }

  void _onExerciseIntensityChanged() {
    final value = _exerciseIntensityController.value.firstOrNull;
    if (value != null) {
      setState(() => _selectedIntensity = value);
    }
  }

  Future<void> _startExercise() async {
    try {
      await ref
          .read(exerciseControllerProvider.notifier)
          .start(_selectedIntensity);
      if (mounted) context.go('/exercise/active');
    } on ExerciseStartException catch (e) {
      if (mounted) {
        showFToast(
          context: context,
          variant: .destructive,
          icon: const Icon(FLucideIcons.circleX),
          title: const Text('Fehler beim Starten des Trainings'),
          description: Text(e.cause),
        );
      }
    }
  }

  @override
  void dispose() {
    _exerciseIntensityController
      ..removeListener(_onExerciseIntensityChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider).settings;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Neues Training'),
        FTabs(
          children: [
            .entry(
              label: const Text('Kontinuierlich'),
              child: FCard(
                builder: (context, style, _) => Padding(
                  padding: style.padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Kontinuierliches Training',
                        style: style.titleTextStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Starte hier ein kontinuierliches Training. Das Training läuft so lange, bis du es beendest.',
                        style: style.subtitleTextStyle,
                      ),
                      const SizedBox(height: 16),
                      FSelectMenuTile<ExerciseIntensity>(
                        autoHide: true,
                        selectControl: .managed(
                          controller: _exerciseIntensityController,
                        ),
                        prefix: const Icon(FLucideIcons.dumbbell),
                        title: const Text('Trainingsintensität'),
                        validator: (value) =>
                            value == null ? 'Bitte eine Auswahl treffen' : null,
                        detailsBuilder: (context, values, _) =>
                            Text(values.first.label),
                        menu: [
                          for (final intensity in ExerciseIntensity.values)
                            .tile(
                              title: Text(
                                '${intensity.label} (${settings?.heartRateFor(intensity)} bpm)',
                              ),
                              value: intensity,
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FButton(
                        onPress: _startExercise,
                        child: const Text('Training starten'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            .entry(
              label: const Text('Intervalltraining'),
              child: FCard(
                builder: (context, style, _) => Padding(
                  padding: style.padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Intervalltraining', style: style.titleTextStyle),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
