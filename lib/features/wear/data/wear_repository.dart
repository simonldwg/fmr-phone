import 'package:flutter/services.dart';
import '../../library/domain/models/song.dart';
import '../domain/models/wear_message.dart';

class WearRepository {
  static const _sendChannel = MethodChannel(
    'com.simonludwig.fitnessmusicrecommender/send_message',
  );
  static const _receiveChannel = EventChannel(
    'com.simonludwig.fitnessmusicrecommender/receive_message',
  );

  late final Stream<WearMessage> messages = _receiveChannel
      .receiveBroadcastStream()
      .cast<Map<Object?, Object?>>()
      .map((raw) => WearMessage.fromJson(raw.cast<String, dynamic>()));

  Future<void> sendStartExerciseMessage({
    required bool useBasicExerciseScreen,
    required bool disablePowerOptimization,
  }) async {
    await _sendChannel.invokeMethod('startExercise', {
      'useBasicExerciseScreen': useBasicExerciseScreen,
      'disablePowerOptimization': disablePowerOptimization,
    });
  }

  Future<void> sendStopExerciseMessage() async {
    await _sendChannel.invokeMethod('stopExercise');
  }

  Future<void> sendCurrentSong(Song song) async {
    await _sendChannel.invokeMethod('updateCurrentSong', {
      'title': song.title,
      'artist': song.artist,
    });
  }
}
