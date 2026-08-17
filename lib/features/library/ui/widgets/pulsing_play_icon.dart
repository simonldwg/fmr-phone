import 'package:flutter/material.dart';
import 'package:forui/assets.dart';

class PulsingPlayIcon extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;

  const PulsingPlayIcon({
    super.key,
    required this.size,
    required this.color,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<PulsingPlayIcon> createState() => _PulsingPlayIconState();
}

class _PulsingPlayIconState extends State<PulsingPlayIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 0.92,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Icon(FLucideIcons.play, size: widget.size, color: widget.color),
    );
  }
}
