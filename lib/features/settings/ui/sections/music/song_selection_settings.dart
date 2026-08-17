import 'package:fitness_music_recommender/features/common/ui/widgets/small_description_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../data/settings_controller_provider.dart';
import '../../../../common/ui/widgets/section_title.dart';

class SongSelectionSettings extends ConsumerWidget {
  const SongSelectionSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider);
    final settings = controller.requireSettings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Songauswahl', smallSize: true),
        Row(
          children: [
            Expanded(
              child: Text(
                'Mehrfaches Abspielen',
                style: context.theme.typography.body.xs,
              ),
            ),
            FSwitch(
              value: settings.allowMultiplePlays,
              onChange: (value) => ref
                  .read(settingsControllerProvider)
                  .updateWith(allowMultiplePlays: value),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const SmallDescriptionText('Wenn du diese Einstellung aktivierst, können Songs auch mehrfach während eines Trainings abgespielt werden.'),
      ],
    );
  }
}
