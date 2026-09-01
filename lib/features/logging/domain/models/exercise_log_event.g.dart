// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_log_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeartRateLogEvent _$HeartRateLogEventFromJson(Map<String, dynamic> json) =>
    HeartRateLogEvent(
      timestamp: DateTime.parse(json['timestamp'] as String),
      bpm: (json['bpm'] as num).toInt(),
    );

Map<String, dynamic> _$HeartRateLogEventToJson(HeartRateLogEvent instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'bpm': instance.bpm,
    };

StepsPerMinuteLogEvent _$StepsPerMinuteLogEventFromJson(
  Map<String, dynamic> json,
) => StepsPerMinuteLogEvent(
  timestamp: DateTime.parse(json['timestamp'] as String),
  steps: (json['steps'] as num).toInt(),
);

Map<String, dynamic> _$StepsPerMinuteLogEventToJson(
  StepsPerMinuteLogEvent instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp.toIso8601String(),
  'steps': instance.steps,
};

StepsPerMinuteStatsLogEvent _$StepsPerMinuteStatsLogEventFromJson(
  Map<String, dynamic> json,
) => StepsPerMinuteStatsLogEvent(
  timestamp: DateTime.parse(json['timestamp'] as String),
  min: (json['min'] as num).toInt(),
  max: (json['max'] as num).toInt(),
  average: (json['average'] as num).toInt(),
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
);

Map<String, dynamic> _$StepsPerMinuteStatsLogEventToJson(
  StepsPerMinuteStatsLogEvent instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp.toIso8601String(),
  'min': instance.min,
  'max': instance.max,
  'average': instance.average,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
};

RunningStepsTotalLogEvent _$RunningStepsTotalLogEventFromJson(
  Map<String, dynamic> json,
) => RunningStepsTotalLogEvent(
  timestamp: DateTime.parse(json['timestamp'] as String),
  steps: (json['steps'] as num).toInt(),
);

Map<String, dynamic> _$RunningStepsTotalLogEventToJson(
  RunningStepsTotalLogEvent instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp.toIso8601String(),
  'steps': instance.steps,
};

SongChangedLogEvent _$SongChangedLogEventFromJson(Map<String, dynamic> json) =>
    SongChangedLogEvent(
      timestamp: DateTime.parse(json['timestamp'] as String),
      previousSong: json['previousSong'] == null
          ? null
          : Song.fromJson(json['previousSong'] as Map<String, dynamic>),
      nextSong: Song.fromJson(json['nextSong'] as Map<String, dynamic>),
      playedDuration: const DurationSecondsConverter().fromJson(
        (json['playedDuration'] as num).toInt(),
      ),
      userSkip: json['userSkip'] as bool? ?? false,
      requestParams: json['requestParams'] == null
          ? null
          : RecommendationParams.fromJson(
              json['requestParams'] as Map<String, dynamic>,
            ),
      recommendation: json['recommendation'] == null
          ? null
          : Recommendation.fromJson(
              json['recommendation'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SongChangedLogEventToJson(
  SongChangedLogEvent instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp.toIso8601String(),
  'previousSong': instance.previousSong?.toJson(),
  'nextSong': instance.nextSong.toJson(),
  'playedDuration': const DurationSecondsConverter().toJson(
    instance.playedDuration,
  ),
  'userSkip': instance.userSkip,
  'requestParams': instance.requestParams?.toJson(),
  'recommendation': instance.recommendation?.toJson(),
};
