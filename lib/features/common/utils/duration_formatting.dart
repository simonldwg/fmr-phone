String formatDurationFromSeconds(num totalSeconds) {
  final duration = Duration(seconds: totalSeconds.round());
  return formatDuration(duration);
}

String formatDuration(Duration duration, {bool alwaysIncludeHours = false}) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60).abs());
  final seconds = twoDigits(duration.inSeconds.remainder(60).abs());

  final h = duration.inHours;
  if (h < 1 && !alwaysIncludeHours) return '$minutes:$seconds';

  final hours = twoDigits(h);
  return '$hours:$minutes:$seconds';
}
