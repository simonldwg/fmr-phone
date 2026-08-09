import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../widgets/settings_section_title.dart';

class TroubleshootingSection extends StatelessWidget {
  const TroubleshootingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle('Fehlerbehebung'),
        FTileGroup(
          children: [
            .tile(
              prefix: const Icon(FLucideIcons.octagonMinus),
              title: Text('Stoppsignal an Uhr senden'),
              onPress: () {
                // TODO: Send stop message
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Sorgt dafür, dass ein fälschlicherweise noch laufendes Training auf der Uhr beendet wird.',
          style: context.theme.typography.body.xs.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
