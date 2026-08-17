import 'package:fitness_music_recommender/features/library/ui/widgets/pulsing_play_icon.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import '../../../common/ui/widgets/ellipse_menu.dart';
import '../../domain/models/extensions/formatting.dart';
import '../../domain/models/song.dart';

FItem songTile(
  Song song, {
  required VoidCallback onPlay,
  required VoidCallback onDelete,
  required VoidCallback onShowDetails,
  required FThemeData theme,
  bool isPlaying = false,
}) {
  return FItem(
    prefix: (isPlaying)
        ? PulsingPlayIcon(color: theme.colors.foreground, size: 20)
        : null,
    title: Text(song.title),
    subtitle: Text('${song.artist} • ${song.durationString}'),
    onPress: onPlay,
    suffix: EllipseMenu(
      menu: [
        .group(
          children: [
            .item(
              prefix: const Icon(FLucideIcons.info),
              title: const Text('Details anzeigen'),
              onPress: onShowDetails,
            ),
          ],
        ),
        .group(
          children: [
            .item(
              variant: .destructive,
              prefix: const Icon(FLucideIcons.trash2),
              title: const Text('Song löschen'),
              onPress: onDelete,
            ),
          ],
        ),
      ],
      buttonSize: .sm,
    ),
  );
}
