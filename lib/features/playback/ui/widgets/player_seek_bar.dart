import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import '../../../common/utils/duration_formatting.dart';
import '../../../library/domain/models/song.dart';
import '../../domain/controllers/playback_controller.dart';

class PlayerSeekBar extends StatefulWidget {
  const PlayerSeekBar({
    required this.song,
    required this.playbackController,
    super.key,
  });

  final Song song;
  final PlaybackController playbackController;

  @override
  State<PlayerSeekBar> createState() => _PlayerSeekBarState();
}

class _PlayerSeekBarState extends State<PlayerSeekBar> {
  StreamSubscription<Duration>? _positionSub;
  double _fraction = 0;
  bool _dragging = false;

  Duration get _duration =>
      Duration(milliseconds: (widget.song.durationS * 1000).round());

  @override
  void initState() {
    super.initState();
    _positionSub = AudioService.position.listen(_onPositionTick);
  }

  @override
  void didUpdateWidget(covariant PlayerSeekBar old) {
    super.didUpdateWidget(old);
    if (old.song.id != widget.song.id && !_dragging) {
      setState(() => _fraction = 0);
    }
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    super.dispose();
  }

  void _onPositionTick(Duration position) {
    if (_dragging) return;
    setState(() => _fraction = _fractionOf(position));
  }

  void _handleSliderChange(FSliderValue v) {
    setState(() {
      _dragging = true;
      _fraction = v.max;
    });
  }

  void _handleSliderEnd(FSliderValue v) {
    widget.playbackController.seek(_duration * v.max);
    setState(() => _dragging = false);
  }

  double _fractionOf(Duration position) {
    final totalMs = _duration.inMilliseconds;
    if (totalMs <= 0) return 0;
    return (position.inMilliseconds / totalMs).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final displayPosition = _duration * _fraction;

    return FSlider(
      style: .delta(
        thumbSize: 12,
        thumbStyle: .delta(color: .delta([.all(context.theme.colors.primary)])),
        inactiveColor: .delta([.all(context.theme.colors.border)]),
        markStyle: .delta(
          labelTextStyle: .delta([.all(.delta(fontSize: 12.5))]),
        ),
      ),
      control: .liftedContinuous(
        value: FSliderValue(max: _fraction),
        onChange: _handleSliderChange,
      ),
      onEnd: _handleSliderEnd,
      tooltipBuilder: (s, v) {
        return Text(formatDuration(_duration * v));
      },
      marks: [
        .mark(
          value: 0,
          tick: false,
          label: Text(
            formatDuration(displayPosition),
            style: .new(fontFeatures: const [FontFeature.tabularFigures()]),
          ),
        ),
        .mark(
          value: 1.0,
          tick: false,
          label: Text(
            formatDuration(_duration),
            style: .new(fontFeatures: const [FontFeature.tabularFigures()]),
          ),
        ),
      ],
    );
  }
}
