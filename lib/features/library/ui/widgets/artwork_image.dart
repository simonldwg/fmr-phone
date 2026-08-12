import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:shimmer/shimmer.dart';

class ArtworkImage extends StatelessWidget {
  const ArtworkImage({required this.url, this.iconSize = 50, super.key});

  final String? url;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final artworkUrl = url;

    if (artworkUrl == null || artworkUrl.isEmpty) {
      return _Placeholder(colors: colors, iconSize: iconSize);
    }

    return CachedNetworkImage(
      imageUrl: artworkUrl,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 250),
      placeholder: (context, url) => _Shimmer(color: colors.secondary),
      errorWidget: (context, url, error) =>
          _Placeholder(colors: colors, iconSize: iconSize),
    );
  }
}

/// placeholder for when the album artwork could not be loaded or the album
/// simply has no artwork image
class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.colors, required this.iconSize});
  final FColors colors;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colors.secondary,
      child: Icon(
        FLucideIcons.disc,
        size: iconSize,
        color: colors.mutedForeground,
      ),
    );
  }
}

/// placeholder for when the album artwork is loading
class _Shimmer extends StatelessWidget {
  const _Shimmer({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: color.withValues(alpha: 0.5),
      child: ColoredBox(color: color),
    );
  }
}
