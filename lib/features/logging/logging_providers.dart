import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/exercise_logger.dart';

final exerciseLoggerProvider = Provider<ExerciseLogger>(
  (ref) => ExerciseLogger(),
);
