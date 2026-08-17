import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../library/domain/models/genre.dart';

part 'filters.g.dart';

@CopyWith()
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