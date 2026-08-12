import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import '../../domain/models/album.dart';
import 'artwork_image.dart';

class AlbumHero extends StatelessWidget {
  const AlbumHero({required this.album, required this.topPadding, super.key});

  final Album album;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
              stops: [0.3, 1.0],
            ).createShader(rect),
            blendMode: BlendMode.dstIn,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Opacity(
                opacity: 0.4,
                child: ArtworkImage(url: album.artworkUrl),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: topPadding,
            bottom: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ArtworkImage(url: album.artworkUrl, iconSize: 64),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                album.albumName,
                textAlign: TextAlign.center,
                style: typography.display.lg.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                album.artist,
                textAlign: TextAlign.center,
                style: typography.body.xs.copyWith(
                  color: colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 16),
              FButton(
                variant: .primary,
                mainAxisSize: .min,
                onPress: () {
                  // TODO: play the whole album
                },
                prefix: const Icon(FLucideIcons.play),
                child: const Text('Abspielen'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
