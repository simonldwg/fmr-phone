import 'dart:async';
import 'package:fitness_music_recommender/features/common/ui/widgets/small_description_text.dart';
import 'package:fitness_music_recommender/features/common/utils/duration_formatting.dart';
import 'package:flutter/widgets.dart';

class ExerciseStopwatch extends StatefulWidget {
  const ExerciseStopwatch({
    required DateTime startTime,
    this.prefix = '',
    super.key,
  }) : referenceTime = startTime,
       _countDown = false;

  const ExerciseStopwatch.countdown({
    required DateTime targetTime,
    this.prefix = '',
    super.key,
  }) : referenceTime = targetTime,
       _countDown = true;

  final DateTime referenceTime;
  final bool _countDown;
  final String prefix;

  @override
  State<ExerciseStopwatch> createState() => _ExerciseStopwatchState();
}

class _ExerciseStopwatchState extends State<ExerciseStopwatch> {
  late Duration _duration = _computeDuration();
  Timer? _timer;

  Duration _computeDuration() {
    final now = DateTime.now();
    final raw = widget._countDown
        ? widget.referenceTime.difference(now)
        : now.difference(widget.referenceTime);
    return widget._countDown && raw.isNegative ? Duration.zero : raw;
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant ExerciseStopwatch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.referenceTime != widget.referenceTime ||
        oldWidget._countDown != widget._countDown) {
      _tick();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final duration = _computeDuration();
    setState(() => _duration = duration);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmallDescriptionText('${widget.prefix}${formatDuration(_duration)}');
  }
}
