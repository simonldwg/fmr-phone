import 'package:fitness_music_recommender/features/settings/domain/models/fmr_settings.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../data/settings_controller_provider.dart';
import '../../domain/models/filters.dart';

class FilterSongLengthSheet extends ConsumerStatefulWidget {
  const FilterSongLengthSheet({super.key});

  @override
  ConsumerState<FilterSongLengthSheet> createState() =>
      _FilterSongLengthSheetState();
}

class _FilterSongLengthSheetState extends ConsumerState<FilterSongLengthSheet> {
  FMRSettings? _currentSettings;
  int _mins = 00;
  int _secs = 00;
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _currentSettings = ref.read(settingsControllerProvider).settings;
    var currentLengthSecs = _currentSettings?.filters.songLength.seconds;
    if (currentLengthSecs != null) {
      _mins = currentLengthSecs ~/ 60;
      _secs = currentLengthSecs % 60;
      _enabled = _currentSettings!.filters.songLength.enabled;
    }
  }

  void _save() {
    if (_enabled && _mins == 0 && _secs < 15) {
      showFToast(
        context: context,
        variant: .destructive,
        icon: const Icon(FLucideIcons.circleX),
        title: Text('Fehler'),
        description: Text(
          'Bitte gib eine gültige Länge (mind. 15 Sekunden) ein.',
        ),
      );
      return;
    }

    int lengthInSeconds = (_mins * 60) + _secs;

    ref
        .read(settingsControllerProvider)
        .updateWith(
          filters: _currentSettings!.filters.copyWith(
            songLength: LengthFilter(lengthInSeconds, _enabled),
          ),
        );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        border: Border(top: BorderSide(color: context.theme.colors.border)),
      ),
      child: SingleChildScrollView(
        padding: const .only(left: 16, right: 16, top: 32, bottom: 48),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              "Songlänge filtern",
              style: context.theme.typography.display.xl2.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colors.foreground,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Hier kannst du angeben, wie lang die Songs maximal sein dürfen, die während eines Trainings abgespielt werden.",
              style: context.theme.typography.body.sm.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Maximale Songlänge festlegen',
                    style: context.theme.typography.body.sm,
                  ),
                ),
                FSwitch(
                  value: _enabled,
                  onChange: (value) => setState(() {
                    _enabled = value;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: IgnorePointer(
                ignoring: !_enabled,
                child: AnimatedOpacity(
                  opacity: _enabled ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 150),
                  child: FPicker(
                    control: .managed(
                      initial: [_mins, _secs],
                      onChange: (values) => setState(() {
                        _mins = values[0] % 10;
                        _secs = values[1] % 60;
                      }),
                    ),
                    children: [
                      FPickerWheel(
                        loop: false,
                        children: [
                          for (var i = 0; i < 10; i++)
                            Text(i.toString().padLeft(2, '0')),
                        ],
                      ),
                      const Text(':'),
                      FPickerWheel(
                        loop: false,
                        children: [
                          for (var i = 0; i < 60; i++)
                            Text(i.toString().padLeft(2, '0')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: .end,
              children: [
                FButton(
                  size: .sm,
                  mainAxisSize: .min,
                  onPress: _save,
                  child: const Text('Speichern'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
