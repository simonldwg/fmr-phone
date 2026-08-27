import 'package:fitness_music_recommender/features/wear/wear_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../common/ui/widgets/section_title.dart';
import '../../../common/ui/widgets/small_description_text.dart';

class TroubleshootingSection extends ConsumerWidget {
  const TroubleshootingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ref.read(wearRepositoryProvider).sendStopExerciseMessage();
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        const SmallDescriptionText(
          'Sorgt dafür, dass ein fälschlicherweise noch laufendes Training auf der Uhr beendet wird.',
        ),
      ],
    );
  }
}
