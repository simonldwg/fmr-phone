// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wear_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeartRateMessage _$HeartRateMessageFromJson(Map<String, dynamic> json) =>
    HeartRateMessage(bpm: (json['bpm'] as num).toInt());

Map<String, dynamic> _$HeartRateMessageToJson(HeartRateMessage instance) =>
    <String, dynamic>{'bpm': instance.bpm};

StepsPerMinuteMessage _$StepsPerMinuteMessageFromJson(
  Map<String, dynamic> json,
) => StepsPerMinuteMessage(steps: (json['steps'] as num).toInt());

Map<String, dynamic> _$StepsPerMinuteMessageToJson(
  StepsPerMinuteMessage instance,
) => <String, dynamic>{'steps': instance.steps};

StepsPerMinuteStatsMessage _$StepsPerMinuteStatsMessageFromJson(
  Map<String, dynamic> json,
) => StepsPerMinuteStatsMessage(
  min: (json['min'] as num).toInt(),
  max: (json['max'] as num).toInt(),
  average: (json['average'] as num).toInt(),
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
);

Map<String, dynamic> _$StepsPerMinuteStatsMessageToJson(
  StepsPerMinuteStatsMessage instance,
) => <String, dynamic>{
  'min': instance.min,
  'max': instance.max,
  'average': instance.average,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
};

RunningStepsTotalMessage _$RunningStepsTotalMessageFromJson(
  Map<String, dynamic> json,
) => RunningStepsTotalMessage(steps: (json['steps'] as num).toInt());

Map<String, dynamic> _$RunningStepsTotalMessageToJson(
  RunningStepsTotalMessage instance,
) => <String, dynamic>{'steps': instance.steps};
