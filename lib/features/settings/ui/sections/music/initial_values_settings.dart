import 'package:fitness_music_recommender/features/common/ui/widgets/small_description_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../data/settings_controller_provider.dart';
import '../../widgets/edit_number_value_sheet.dart';

class InitialValuesSettings extends ConsumerWidget {
  const InitialValuesSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider);
    final settings = controller.requireSettings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FTileGroup(
          label: const Text('Startwerte'),
          children: [
            .tile(
              prefix: const Icon(FLucideIcons.metronome),
              title: const Text('BPM moderates Training'),
              details: Text(settings.initialBpmModerate.toString()),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showEditNumberValueSheet(
                context: context,
                title: 'BPM moderates Training',
                description:
                    'Lege hier das Songtempo für moderates Training fest, das in die erste Songempfehlung zu Beginn des Trainings einfließt.',
                initialValue: settings.initialBpmModerate,
                onSave: (value) => ref
                    .read(settingsControllerProvider)
                    .updateWith(initialBpmModerate: value),
                label: 'Songtempo (BPM)',
                hint: 'z.B. 131',
                min: 50,
                max: 250,
              ),
            ),
            .tile(
              prefix: const Icon(FLucideIcons.metronome),
              title: const Text('BPM starkes Training'),
              details: Text(settings.initialBpmVigorous.toString()),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showEditNumberValueSheet(
                context: context,
                title: 'BPM starkes Training',
                description:
                    'Lege hier das Songtempo für starkes Training fest, das in die erste Songempfehlung zu Beginn des Trainings einfließt.',
                initialValue: settings.initialBpmVigorous,
                onSave: (value) => ref
                    .read(settingsControllerProvider)
                    .updateWith(initialBpmVigorous: value),
                label: 'Songtempo (BPM)',
                hint: 'z.B. 136',
                min: 50,
                max: 250,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const SmallDescriptionText(
          'Passt die Songtempo-Werte an, die in die erste Songempfehlung zu Beginn des Trainings einfließen. In die erste Song-Empfehlung fließt nur das Songtempo ein, nicht der Arousal-Wert.',
        ),
      ],
    );
  }
}
