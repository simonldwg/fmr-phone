import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import '../../../common/ui/widgets/ellipse_menu.dart';
import '../../domain/models/formatting.dart';
import '../../domain/models/song.dart';

FItem songTile(
  Song song, {
  required VoidCallback onDelete,
  required VoidCallback onShowDetails,
}) {
  return FItem(
    title: Text(song.title),
    subtitle: Text('${song.artist} • ${song.durationString}'),
    prefix: FButton.icon(
      variant: .ghost,
      onPress: () {
        // TODO: play single song
      },
      child: const Icon(FLucideIcons.play),
    ),
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
