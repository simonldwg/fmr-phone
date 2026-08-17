import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../../common/ui/widgets/section_title.dart';
import '../../../common/ui/widgets/small_description_text.dart';

class TroubleshootingSection extends StatelessWidget {
  const TroubleshootingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Fehlerbehebung'),
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
        const SmallDescriptionText('Sorgt dafür, dass ein fälschlicherweise noch laufendes Training auf der Uhr beendet wird.'),
      ],
    );
  }
}
