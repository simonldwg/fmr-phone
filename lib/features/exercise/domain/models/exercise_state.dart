import 'package:copy_with_extension/copy_with_extension.dart';
import 'exercise.dart';

part 'exercise_state.g.dart';

@CopyWith()
class ExerciseState {
  const ExerciseState({
    this.exercise,
    this.latestHeartRate,
    this.isStarting = false,
  });

  const ExerciseState.idle()
    : exercise = null,
      latestHeartRate = null,
      isStarting = false;

  const ExerciseState.starting()
    : exercise = null,
      latestHeartRate = null,
      isStarting = true;

  final Exercise? exercise;
  final int? latestHeartRate;
  final bool isStarting;

  bool get isRunning => exercise != null;
}
