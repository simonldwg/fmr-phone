import 'dart:async';
import 'package:fitness_music_recommender/features/common/ui/widgets/small_description_text.dart';
import 'package:flutter/widgets.dart';

class ExerciseStopwatch extends StatefulWidget {
  const ExerciseStopwatch({
    required this.startTime,
    this.prefix = '',
    super.key,
  });
  final DateTime startTime;
  final String prefix;

  @override
  State<ExerciseStopwatch> createState() => _ExerciseStopwatchState();
}

class _ExerciseStopwatchState extends State<ExerciseStopwatch> {
  late Duration _elapsed = DateTime.now().difference(widget.startTime);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed = DateTime.now().difference(widget.startTime));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return SmallDescriptionText('${widget.prefix}${_format(_elapsed)}');
  }
}
