sealed class WearMessage {
  const WearMessage();

  factory WearMessage.fromMap(Map<String, dynamic> map) {
    return switch (map['type'] as String) {
      'HeartRate' => HeartRateMessage(bpm: map['bpm'] as int),
      'ExerciseStarted' => const ExerciseStartedMessage(),
      'StopExercise' => const StopExerciseMessage(),
      'ExerciseStopped' => const ExerciseStoppedMessage(),
      'PlayPause' => const PlayPauseMessage(),
      'NextSong' => const NextSongMessage(),
      final t => throw FormatException('Unknown message type: $t'),
    };
  }
}

class HeartRateMessage extends WearMessage {
  final int bpm;
  const HeartRateMessage({required this.bpm});
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
