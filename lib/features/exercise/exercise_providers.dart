import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/controllers/exercise_controller.dart';
import 'domain/models/exercise_state.dart';

final exerciseControllerProvider =
    NotifierProvider<ExerciseController, ExerciseState>(ExerciseController.new);
