import 'package:fitness_music_recommender/features/common/ui/widgets/ellipse_menu.dart';
import 'package:fitness_music_recommender/features/common/ui/widgets/small_description_text.dart';
import 'package:fitness_music_recommender/features/exercise/ui/widgets/exercise_stopwatch.dart';
import 'package:fitness_music_recommender/features/playback/playback_providers.dart';
import 'package:fitness_music_recommender/features/settings/data/settings_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../common/ui/widgets/confirmation_dialog.dart';
import '../../../playback/ui/widgets/artwork_background_color.dart';
import '../../../playback/ui/widgets/full_player.dart';
import '../../exercise_providers.dart';

class ActiveExercisePage extends ConsumerWidget {
  const ActiveExercisePage({super.key});

  Future<void> _confirmAndStopExercise(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Training beenden?',
      message: 'Möchtest du das aktuelle Training wirklich beenden?',
      confirmText: 'Beenden',
      destructive: true,
    );

    if (confirmed && context.mounted) {
      await ref.read(exerciseControllerProvider.notifier).stop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If the state changes from running to not running -> go back to the
    // overview page
    ref.listen(exerciseControllerProvider, (previous, next) {
      if ((previous?.isRunning ?? false) && !next.isRunning) {
        context.go('/exercise/overview');
      }
    });

    final exerciseController = ref.watch(exerciseControllerProvider);
    final heartRate = exerciseController.latestHeartRate;
    final exercise = exerciseController.exercise;

    if (exercise == null) {
      return const Center(child: FCircularProgress(size: .lg));
    }

    final settings = ref.watch(settingsControllerProvider).requireSettings;
    final targetHeartRate = settings.heartRateFor(exercise.intensity);
    final currentSong = ref.watch(currentSongProvider);

    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Stack(
      children: [
        Positioned.fill(
          child: ArtworkBackgroundColor(
            artworkUrl: currentSong?.album.artworkUrl,
            fallbackColor: colors.background,
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colors.background.withValues(alpha: 0.1),
                  colors.background.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
        ),
        FScaffold(
          childPad: false,
          scaffoldStyle: .delta(
            headerDecoration: .boxDelta(color: Colors.transparent),
            footerDecoration: .boxDelta(
              color: colors.background.withValues(alpha: 0.3),
              border: null,
            ),
            backgroundColor: Colors.transparent,
          ),
          header: FHeader(
            title: const Text('Training'),
            suffixes: [
              EllipseMenu(
                menu: [
                  if (currentSong != null)
                    .group(
                      children: [
                        .item(
                          prefix: const Icon(FLucideIcons.info),
                          title: const Text('Songdetails anzeigen'),
                          onPress: () => context.push(
                            '/standalone/song',
                            extra: currentSong,
                          ),
                        ),
                      ],
                    ),
                ],
                buttonSize: .lg,
              ),
            ],
          ),
          footer: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
            child: Column(
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
                            'Intensität: ${exercise.intensity.label}',
                            style: typography.body.md,
                          ),
                          ExerciseStopwatch(
                            prefix: 'Training läuft seit ',
                            startTime: exercise.startTime,
                          ),
                        ],
                      ),
                    ),
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
                        (targetHeartRate > heartRate)
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
                      onPress: () async => {
                        await ref
                            .read(exerciseControllerProvider.notifier)
                            .cycleIntensity(),
                      },
                      prefix: const Icon(FLucideIcons.dumbbell, size: 20),
                      child: const Text('Intensität wechseln'),
                    ),
                    FButton(
                      size: .xs,
                      variant: .destructive,
                      onPress: () => _confirmAndStopExercise(context, ref),
                      prefix: const Icon(FLucideIcons.square, size: 20),
                      child: const Text('Training beenden'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: const FullPlayer(),
          ),
        ),
      ],
    );
  }
}
