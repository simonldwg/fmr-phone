import 'package:copy_with_extension/copy_with_extension.dart';
import 'exercise.dart';

part 'exercise_state.g.dart';

@CopyWith()
class ExerciseState {
  const ExerciseState({this.exercise, this.latestHeartRate});
  const ExerciseState.idle() : exercise = null, latestHeartRate = null;

  final Exercise? exercise;
  final int? latestHeartRate;

  bool get isRunning => exercise != null;
}
