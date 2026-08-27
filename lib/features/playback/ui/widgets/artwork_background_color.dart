import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator_master/palette_generator_master.dart';

class ArtworkBackgroundColor extends StatefulWidget {
  const ArtworkBackgroundColor({
    required this.artworkUrl,
    required this.fallbackColor,
    super.key,
  });

  final String? artworkUrl;
  final Color fallbackColor;

  @override
  State<ArtworkBackgroundColor> createState() => _ArtworkBackgroundColorState();
}

class _ArtworkBackgroundColorState extends State<ArtworkBackgroundColor> {
  final Map<String, Color> _cache = {};
  Color? _color;

  @override
  void initState() {
    super.initState();
    _resolve(widget.artworkUrl);
  }

  @override
  void didUpdateWidget(covariant ArtworkBackgroundColor old) {
    super.didUpdateWidget(old);
    if (old.artworkUrl != widget.artworkUrl) _resolve(widget.artworkUrl);
  }

  Future<void> _resolve(String? url) async {
    if (url == null) {
      setState(() => _color = null);
      return;
    }
    final cached = _cache[url];
    if (cached != null) {
      setState(() => _color = cached);
      return;
    }
    final generator = await PaletteGeneratorMaster.fromImageProvider(
      CachedNetworkImageProvider(url),
      maximumColorCount: 16,
    );
    if (!mounted || widget.artworkUrl != url) return;
    final color =
        generator.vibrantColor?.color ??
        generator.dominantColor?.color ??
        generator.mutedColor?.color;
    if (color != null) _cache[url] = color;
    setState(() => _color = color);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      color: _color ?? widget.fallbackColor,
    );
  }
}
