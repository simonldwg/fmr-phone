import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../../../data/settings_controller_provider.dart';
import '../../widgets/setting_slider.dart';
import '../../widgets/settings_section_title.dart';

class WeightSettings extends ConsumerWidget {
  const WeightSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FTheme.of(context);
    final controller = ref.watch(settingsControllerProvider);
    final settings = controller.requireSettings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle('Stärke', smallSize: true),
        SettingSlider(
          label: 'Arousal',
          min: 0,
          max: 3,
          initialValue: settings.arousalWeight,
          onValueChanged: (value) => ref
              .read(settingsControllerProvider)
              .updateWith(arousalWeight: value),
        ),
        const SizedBox(height: 12),
        SettingSlider(
          label: 'BPM',
          min: 0,
          max: 3,
          initialValue: settings.bpmWeight,
          onValueChanged: (value) =>
              ref.read(settingsControllerProvider).updateWith(bpmWeight: value),
        ),
        const SizedBox(height: 12),
        Text(
          'Gibt an, wie stark die einzelnen Parameter in der Empfehlung gewichtet werden.',
          style: theme.typography.body.xs.copyWith(
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
