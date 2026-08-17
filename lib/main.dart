import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import 'app/fmr_app.dart';
import 'features/playback/domain/fmr_audio_handler.dart';
import 'features/playback/playback_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final audioHandler = await AudioService.init(
    builder: () => FMRAudioHandler(AudioPlayer()),
    config: const AudioServiceConfig(
      androidNotificationChannelId:
          'com.simonludwig.fitnessmusicrecommender.audio',
      androidNotificationChannelName: 'Wiedergabe',
      androidStopForegroundOnPause: false,
    ),
  );

  runApp(
    ProviderScope(
      overrides: [audioHandlerProvider.overrideWithValue(audioHandler)],
      child: const FMRPhoneApp(),
    ),
  );
}
