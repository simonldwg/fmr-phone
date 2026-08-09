import 'package:fitness_music_recommender/features/common/domain/models/genre.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fmr_settings.g.dart';

// This module uses automatic code generation for the JSON serialization.
// If you want to change this source code, make sure to run the code generation
// as well.
// To start a continuous watcher for always generating the boilerplate code, run:
// dart run build_runner watch
// To perform code generation once, run:
// dart run build_runner build

@JsonSerializable()
class FMRSettings {
  String apiUrl;
  bool useBasicExerciseScreen;
  int targetHrModerate;
  int targetHrVigorous;
  double arousalWeight;
  double bpmWeight;
  Filters filters;
  bool allowMultiplePlays;
  int initialBpmModerate;
  int initialBpmVigorous;

  FMRSettings(
    this.apiUrl,
    this.useBasicExerciseScreen,
    this.targetHrModerate,
    this.targetHrVigorous,
    this.arousalWeight,
    this.bpmWeight,
    this.filters,
    this.allowMultiplePlays,
    this.initialBpmModerate,
    this.initialBpmVigorous,
  );

  factory FMRSettings.fromJson(Map<String, dynamic> json) =>
      _$FMRSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$FMRSettingsToJson(this);
}

@JsonSerializable()
class Filters {
  Set<Genre> genres;
  LengthFilter songLength;
  FeatureFilter valence;
  FeatureFilter authenticity;
  FeatureFilter timeliness;
  FeatureFilter complexity;
  FeatureFilter danceability;
  FeatureFilter tonal;
  FeatureFilter voice;

  Filters(
    this.genres,
    this.songLength,
    this.valence,
    this.authenticity,
    this.timeliness,
    this.complexity,
    this.danceability,
    this.tonal,
    this.voice,
  );

  Filters copyWith({
    Set<Genre>? genres,
    LengthFilter? songLength,
    FeatureFilter? valence,
    FeatureFilter? authenticity,
    FeatureFilter? timeliness,
    FeatureFilter? complexity,
    FeatureFilter? danceability,
    FeatureFilter? tonal,
    FeatureFilter? voice,
  }) => Filters(
    genres ?? this.genres,
    songLength ?? this.songLength,
    valence ?? this.valence,
    authenticity ?? this.authenticity,
    timeliness ?? this.timeliness,
    complexity ?? this.complexity,
    danceability ?? this.danceability,
    tonal ?? this.tonal,
    voice ?? this.voice,
  );

  factory Filters.fromJson(Map<String, dynamic> json) =>
      _$FiltersFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersToJson(this);
}

@JsonSerializable()
class LengthFilter {
  int seconds;
  bool enabled;

  LengthFilter(this.seconds, this.enabled);

  factory LengthFilter.fromJson(Map<String, dynamic> json) =>
      _$LengthFilterFromJson(json);

  Map<String, dynamic> toJson() => _$LengthFilterToJson(this);
}

@JsonSerializable()
class FeatureFilter {
  double value;
  bool enabled;

  FeatureFilter(this.value, this.enabled);

  factory FeatureFilter.fromJson(Map<String, dynamic> json) =>
      _$FeatureFilterFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureFilterToJson(this);
}
