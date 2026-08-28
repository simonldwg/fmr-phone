import 'package:fitness_music_recommender/features/exercise/domain/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../common/ui/widgets/small_description_text.dart';
import 'exercise_stopwatch.dart';

class ContinuousExerciseFooter extends StatelessWidget {
  final ContinuousExercise exercise;
  final int? heartRate;
  final int targetHeartRate;
  final VoidCallback onStopExercise;
  final VoidCallback onChangeIntensity;

  const ContinuousExerciseFooter({
    super.key,
    required this.exercise,
    required this.heartRate,
    required this.targetHeartRate,
    required this.onStopExercise,
    required this.onChangeIntensity,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colors = context.theme.colors;

    return Column(
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisSize: .max,
          mainAxisAlignment: .start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Intensität: ${exercise.currentIntensity.label}',
                    style: typography.body.md,
                  ),
                  ExerciseStopwatch(
                    prefix: 'Training läuft seit ',
                    startTime: exercise.startTime,
                  ),
                ],
              ),
            ),
            Icon(FLucideIcons.heartPulse, color: colors.primary, size: 22),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    heartRate != null ? '$heartRate bpm' : '--',
                    style: typography.body.md.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  SmallDescriptionText('Ziel: $targetHeartRate bpm'),
                ],
              ),
            ),
            if (heartRate != null)
              Icon(
                (targetHeartRate > heartRate!)
                    ? FLucideIcons.arrowUpCircle
                    : FLucideIcons.arrowDownCircle,
                color: colors.primary,
                size: 22,
              ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: .center,
          spacing: 16,
          children: [
            FButton(
              size: .xs,
              variant: .ghost,
              onPress: onChangeIntensity,
              prefix: const Icon(FLucideIcons.dumbbell, size: 20),
              child: const Text('Intensität wechseln'),
            ),
            FButton(
              size: .xs,
              variant: .destructive,
              onPress: onStopExercise,
              prefix: const Icon(FLucideIcons.square, size: 20),
              child: const Text('Training beenden'),
            ),
          ],
        ),
      ],
    );
  }
}
