import 'package:json_annotation/json_annotation.dart';
import '../../../library/domain/models/song.dart';
import '../../../recommendation/domain/models/recommendation.dart';
import '../../../recommendation/domain/models/recommendation_params.dart';

part 'exercise_log_event.g.dart';

class DurationSecondsConverter implements JsonConverter<Duration, int> {
  const DurationSecondsConverter();
  @override
  Duration fromJson(int json) => Duration(seconds: json);
  @override
  int toJson(Duration duration) => duration.inSeconds;
}

sealed class ExerciseLogEvent {
  const ExerciseLogEvent({required this.timestamp});
  final DateTime timestamp;

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class HeartRateLogEvent extends ExerciseLogEvent {
  HeartRateLogEvent({required super.timestamp, required this.bpm});
  final int bpm;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'heartRate',
    ..._$HeartRateLogEventToJson(this),
  };
}

@JsonSerializable()
class StepsPerMinuteLogEvent extends ExerciseLogEvent {
  StepsPerMinuteLogEvent({required super.timestamp, required this.steps});
  final int steps;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'stepsPerMinute',
    ..._$StepsPerMinuteLogEventToJson(this),
  };
}

@JsonSerializable()
class StepsPerMinuteStatsLogEvent extends ExerciseLogEvent {
  StepsPerMinuteStatsLogEvent({
    required super.timestamp,
    required this.min,
    required this.max,
    required this.average,
    required this.startTime,
    required this.endTime,
  });
  final int min;
  final int max;
  final int average;
  final DateTime startTime;
  final DateTime endTime;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'stepsPerMinuteStats',
    ..._$StepsPerMinuteStatsLogEventToJson(this),
  };
}

@JsonSerializable()
class RunningStepsTotalLogEvent extends ExerciseLogEvent {
  RunningStepsTotalLogEvent({required super.timestamp, required this.steps});
  final int steps;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'runningStepsTotal',
    ..._$RunningStepsTotalLogEventToJson(this),
  };
}

@JsonSerializable(explicitToJson: true)
class SongChangedLogEvent extends ExerciseLogEvent {
  SongChangedLogEvent({
    required super.timestamp,
    required this.previousSong,
    required this.nextSong,
    @DurationSecondsConverter() required this.playedDuration,
    this.userSkip = false,
    this.requestParams,
    this.recommendation,
  });
  final Song? previousSong;
  final Song nextSong;
  @DurationSecondsConverter()
  final Duration playedDuration;
  final bool userSkip;
  final RecommendationParams? requestParams;
  final Recommendation? recommendation;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'songChanged',
    ..._$SongChangedLogEventToJson(this),
  };
}
