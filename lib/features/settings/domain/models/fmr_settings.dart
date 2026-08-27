import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:fitness_music_recommender/features/recommendation/domain/models/song_selection_strategy.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../exercise/domain/models/exercise_intensity.dart';
import '../../../recommendation/domain/models/filters.dart';

part 'fmr_settings.g.dart';

// This module uses automatic code generation for the JSON serialization and
// copyWith() method.
// If you want to change this source code, make sure to run the code generation
// as well.
// To start a continuous watcher for always generating the boilerplate code, run:
// dart run build_runner watch
// To perform code generation once, run:
// dart run build_runner build

@CopyWith()
@JsonSerializable()
class FMRSettings {
  String apiUrl;
  bool useBasicExerciseScreen;
  Map<ExerciseIntensity, int> targetHeartRates;
  double arousalWeight;
  double bpmWeight;
  Filters filters;
  bool allowMultiplePlays;
  SongSelectionStrategy selectionStrategy;
  int initialBpmModerate;
  int initialBpmVigorous;

  FMRSettings(
    this.apiUrl,
    this.useBasicExerciseScreen,
    this.targetHeartRates,
    this.arousalWeight,
    this.bpmWeight,
    this.filters,
    this.allowMultiplePlays,
    this.selectionStrategy,
    this.initialBpmModerate,
    this.initialBpmVigorous,
  );

  int heartRateFor(ExerciseIntensity intensity) => targetHeartRates[intensity]!;

  factory FMRSettings.fromJson(Map<String, dynamic> json) =>
      _$FMRSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$FMRSettingsToJson(this);
}
