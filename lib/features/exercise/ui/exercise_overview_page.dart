import 'package:fitness_music_recommender/features/exercise/exercise_providers.dart';
import 'package:fitness_music_recommender/features/exercise/ui/widgets/new_exercise_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

class ExerciseOverviewPage extends ConsumerWidget {
  const ExerciseOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final starting = ref.watch(
      exerciseControllerProvider.select((s) => s.isRunning),
    );
    final colors = context.theme.colors;

    return FScaffold(
      header: const FHeader(title: Text('Training')),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [NewExerciseSection()],
            ),
          ),
          if (starting)
            Positioned.fill(
              child: ColoredBox(
                color: colors.background.withValues(alpha: 0.7),
                child: const Center(child: FCircularProgress(size: .lg)),
              ),
            ),
        ],
      ),
    );
  }
}
