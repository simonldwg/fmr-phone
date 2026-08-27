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
      .map((raw) => WearMessage.fromMap(raw.cast<String, dynamic>()));

  Future<void> sendStartExerciseMessage({
    bool useBasicExerciseScreen = false,
  }) async {
    await _sendChannel.invokeMethod('startExercise', {
      'useBasicExerciseScreen': useBasicExerciseScreen,
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
