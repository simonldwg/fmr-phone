import 'package:json_annotation/json_annotation.dart';

part 'wear_message.g.dart';

sealed class WearMessage {
  const WearMessage();

  factory WearMessage.fromJson(Map<String, dynamic> json) {
    return switch (json['type'] as String) {
      'HeartRate' => HeartRateMessage.fromJson(json),
      'ExerciseStarted' => const ExerciseStartedMessage(),
      'StopExercise' => const StopExerciseMessage(),
      'ExerciseStopped' => const ExerciseStoppedMessage(),
      'PlayPause' => const PlayPauseMessage(),
      'NextSong' => const NextSongMessage(),
      'StepsPerMinute' => StepsPerMinuteMessage.fromJson(json),
      'StepsPerMinuteStats' => StepsPerMinuteStatsMessage.fromJson(json),
      'RunningStepsTotal' => RunningStepsTotalMessage.fromJson(json),
      final t => throw FormatException('Unknown message type: $t'),
    };
  }
}

class ExerciseStartedMessage extends WearMessage {
  const ExerciseStartedMessage();
}

class StopExerciseMessage extends WearMessage {
  const StopExerciseMessage();
}

class ExerciseStoppedMessage extends WearMessage {
  const ExerciseStoppedMessage();
}

class PlayPauseMessage extends WearMessage {
  const PlayPauseMessage();
}

class NextSongMessage extends WearMessage {
  const NextSongMessage();
}

@JsonSerializable()
class HeartRateMessage extends WearMessage {
  final int bpm;

  const HeartRateMessage({required this.bpm});

  factory HeartRateMessage.fromJson(Map<String, dynamic> json) =>
      _$HeartRateMessageFromJson(json);

  Map<String, dynamic> toJson() => _$HeartRateMessageToJson(this);
}

@JsonSerializable()
class StepsPerMinuteMessage extends WearMessage {
  final int steps;

  const StepsPerMinuteMessage({required this.steps});

  factory StepsPerMinuteMessage.fromJson(Map<String, dynamic> json) =>
      _$StepsPerMinuteMessageFromJson(json);

  Map<String, dynamic> toJson() => _$StepsPerMinuteMessageToJson(this);
}

@JsonSerializable()
class StepsPerMinuteStatsMessage extends WearMessage {
  final int min;
  final int max;
  final int average;
  final DateTime startTime;
  final DateTime endTime;

  const StepsPerMinuteStatsMessage({
    required this.min,
    required this.max,
    required this.average,
    required this.startTime,
    required this.endTime,
  });

  factory StepsPerMinuteStatsMessage.fromJson(Map<String, dynamic> json) =>
      _$StepsPerMinuteStatsMessageFromJson(json);

  Map<String, dynamic> toJson() => _$StepsPerMinuteStatsMessageToJson(this);
}

@JsonSerializable()
class RunningStepsTotalMessage extends WearMessage {
  final int steps;

  const RunningStepsTotalMessage({required this.steps});

  factory RunningStepsTotalMessage.fromJson(Map<String, dynamic> json) =>
      _$RunningStepsTotalMessageFromJson(json);

  Map<String, dynamic> toJson() => _$RunningStepsTotalMessageToJson(this);
}
