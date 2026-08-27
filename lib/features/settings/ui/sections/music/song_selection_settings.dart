import 'package:fitness_music_recommender/features/common/ui/widgets/small_description_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../../recommendation/domain/models/song_selection_strategy.dart';
import '../../../data/settings_controller_provider.dart';
import '../../../../common/ui/widgets/section_title.dart';

class SongSelectionSettings extends ConsumerStatefulWidget {
  const SongSelectionSettings({super.key});

  @override
  ConsumerState<SongSelectionSettings> createState() =>
      _SongSelectionSettingsState();
}

class _SongSelectionSettingsState extends ConsumerState<SongSelectionSettings> {
  late final FMultiValueNotifier<SongSelectionStrategy>
  _songSelectionController;

  @override
  void initState() {
    super.initState();
    final initialStrategy = ref
        .read(settingsControllerProvider)
        .requireSettings
        .selectionStrategy;

    _songSelectionController = FMultiValueNotifier<SongSelectionStrategy>.radio(
      initialStrategy,
    )..addListener(_onSongSelectionChanged);
  }

  void _onSongSelectionChanged() {
    final value = _songSelectionController.value.firstOrNull;
    if (value != null) {
      ref.read(settingsControllerProvider).updateWith(selectionStrategy: value);
    }
  }

  @override
  void dispose() {
    _songSelectionController
      ..removeListener(_onSongSelectionChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        const SmallDescriptionText(
          'Wenn du diese Einstellung aktivierst, können Songs auch mehrfach während eines Trainings abgespielt werden.',
        ),
        const SizedBox(height: 16),
        FSelectMenuTile<SongSelectionStrategy>(
          selectControl: .managed(controller: _songSelectionController),
          validator: (value) =>
              value == null ? 'Bitte eine Auswahl treffen' : null,
          title: const Text('Songauswahl'),
          detailsBuilder: (_, values, _) => Text(values.first.label),
          menu: [
            for (final strategy in SongSelectionStrategy.values)
              .tile(title: Text(strategy.label), value: strategy),
          ],
        ),
        const SizedBox(height: 16),
        const SmallDescriptionText(
          'Aus den 10 passendsten Songs wird einer ausgewählt, der abgespielt '
          'wird. Hier kannst du festlegen, wie diese Auswahl stattfindet (in '
          'Bezug auf die Songlänge). Dies dient dazu, dass kürzere Songs '
          'gespielt werden und lange Songs nicht den Effekt des '
          'Empfehlungsalgorithmus verringern.',
        ),
      ],
    );
  }
}
