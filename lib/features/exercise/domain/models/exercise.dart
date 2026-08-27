import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:fitness_music_recommender/features/exercise/domain/models/exercise_intensity.dart';

part 'exercise.g.dart';

@CopyWith()
class Exercise {
  final ExerciseIntensity intensity;
  final DateTime startTime;

  const Exercise(this.intensity, this.startTime);
}
