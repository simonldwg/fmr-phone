import 'package:copy_with_extension/copy_with_extension.dart';

import 'exercise_intensity.dart';

part 'interval.g.dart';

@CopyWith()
class Interval {
  final ExerciseIntensity intensity;
  final Duration duration;

  const Interval(this.intensity, this.duration);
}
