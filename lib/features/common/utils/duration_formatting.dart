String formatDuration(num totalSeconds) {
  final duration = Duration(seconds: totalSeconds.round());
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60).abs());
  final seconds = twoDigits(duration.inSeconds.remainder(60).abs());
  return '$minutes:$seconds';
}
