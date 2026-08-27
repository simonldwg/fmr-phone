import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'models/extensions/song_media_item.dart';
import '../../library/domain/models/song.dart';
import 'models/fmr_playback_state.dart';
import 'sources/playback_source.dart';

class FMRAudioHandler extends BaseAudioHandler {
  FMRAudioHandler(this._player) {
    // When a playback event is emitted by just_audio, update this audio service
    _player.playbackEventStream.listen(_updateState);

    // When the song is finished, play the next song
    _player.processingStateStream
        .where((s) => s == ProcessingState.completed)
        .listen((_) => skipToNext());
  }

  final AudioPlayer _player;
  PlaybackSource? _source;

  final BehaviorSubject<FMRPlaybackState> _state = BehaviorSubject.seeded(
    const FMRPlaybackState.idle(),
  );
  ValueStream<FMRPlaybackState> get state => _state;

  Duration get position => _player.position;

  void setSource(PlaybackSource source) => _source = source;

  Future<void> startPlayingFromCurrentPosition() async {
    if (_source == null) return;
    final song = await _source!.getCurrentSong();
    await _playSong(song);
  }

  @override
  Future<void> skipToNext() async {
    if (_source == null || !_source!.canGoNext()) return;
    final song = await _source!.next();
    await _playSong(song);
  }

  @override
  Future<void> skipToPrevious() async {
    if (_source == null || !_source!.canGoPrevious()) return;
    final song = await _source!.previous();
    await _playSong(song);
  }

  Future<void> _playSong(Song song) async {
    // update the current song
    _state.add(_state.value.copyWith(song: song));
    mediaItem.add(song.toMediaItem());
    await _player.setAudioSource(AudioSource.uri(Uri.parse(song.songUrl)));
    _player.play();
  }

  void _updateState(PlaybackEvent event) {
    List<MediaControl> controls = _getControls();
    final compactIndices = List.generate(controls.length.clamp(0, 3), (i) => i);

    final canNext = _source?.canGoNext() ?? false;
    final canPrev = _source?.canGoPrevious() ?? false;
    final playing = _player.playing;
    final ps = _player.processingState;
    final loading =
        ps == ProcessingState.loading || ps == ProcessingState.buffering;

    _state.add(
      _state.value.copyWith(
        playing: playing,
        loading: loading,
        canGoNext: canNext,
        canGoPrevious: canPrev,
      ),
    );

    playbackState.add(
      playbackState.value.copyWith(
        controls: controls,
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: compactIndices,
        processingState: switch (ps) {
          ProcessingState.idle => AudioProcessingState.idle,
          ProcessingState.loading => AudioProcessingState.loading,
          ProcessingState.buffering => AudioProcessingState.buffering,
          ProcessingState.ready => AudioProcessingState.ready,
          ProcessingState.completed => AudioProcessingState.completed,
        },
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
      ),
    );
  }

  List<MediaControl> _getControls() {
    List<MediaControl> controls = [
      if (_player.playing) MediaControl.pause else MediaControl.play,
    ];

    if (_source != null && _source!.canGoPrevious()) {
      controls.insert(0, MediaControl.skipToPrevious);
    }

    if (_source != null && _source!.canGoNext()) {
      controls.add(MediaControl.skipToNext);
    }

    return controls;
  }

  @override
  Future<void> play() => _player.play();
  @override
  Future<void> pause() => _player.pause();
  @override
  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> _fadeOutVolume(Duration duration) async {
    if (!_player.playing) return;

    const steps = 100;
    final stepDuration = duration ~/ steps;
    final startVolume = _player.volume;
    for (var i = 1; i <= steps; i++) {
      await Future.delayed(stepDuration);
      final v = startVolume * (1 - i / steps);
      await _player.setVolume(v.clamp(0.0, 1.0));
    }
  }

  @override
  Future<void> stop({
    bool fadeOut = false,
    Duration fadeOutDuration = const Duration(seconds: 3),
  }) async {
    if (fadeOut) {
      await _fadeOutVolume(fadeOutDuration);
    }
    await _player.stop();
    await super.stop();
    await _player.setVolume(1.0);
    _state.add(FMRPlaybackState.idle());
  }

  Future<void> dispose() async {
    await _state.close();
  }
}
