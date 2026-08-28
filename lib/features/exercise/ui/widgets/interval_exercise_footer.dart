import 'package:fitness_music_recommender/features/exercise/domain/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../common/ui/widgets/small_description_text.dart';
import 'exercise_stopwatch.dart';

class IntervalExerciseFooter extends StatelessWidget {
  final IntervalExercise exercise;
  final int? heartRate;
  final int targetHeartRate;
  final VoidCallback onStopExercise;

  const IntervalExerciseFooter({
    super.key,
    required this.exercise,
    required this.heartRate,
    required this.targetHeartRate,
    required this.onStopExercise,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final colors = context.theme.colors;

    final now = DateTime.now();
    final nextInterval = exercise.getNextInterval(now);
    final nextTransition = exercise.nextTransitionAt(now);

    return Column(
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisSize: .max,
          mainAxisAlignment: .start,
          spacing: 16,
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
                  const SizedBox(height: 6),
                  if (nextTransition != null)
                    ExerciseStopwatch.countdown(
                      prefix: (nextInterval == null)
                          ? 'Training endet in '
                          : 'Nächstes Intervall (${nextInterval.intensity.label}) in ',
                      targetTime: nextTransition,
                    ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      FLucideIcons.heartPulse,
                      color: colors.primary,
                      size: 22,
                    ),
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
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
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
                const SizedBox(height: 16),
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
        ),
      ],
    );
  }
}
