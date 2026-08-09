import 'dart:ui';

import 'package:fitness_music_recommender/features/settings/domain/models/formatting.dart';
import 'package:fitness_music_recommender/features/settings/ui/widgets/filter_song_length_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../../../data/settings_controller_provider.dart';
import '../../../domain/models/fmr_settings.dart';
import '../../widgets/setting_slider.dart';
import '../../widgets/settings_section_title.dart';

class FilterSettings extends ConsumerWidget {
  const FilterSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider);
    final settings = controller.requireSettings;
    final filters = settings.filters;

    void save(Filters updated) =>
        ref.read(settingsControllerProvider).updateWith(filters: updated);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle('Filter', smallSize: true),
        FTileGroup(
          children: [
            .tile(
              prefix: const Icon(FLucideIcons.music),
              title: const Text('Genre'),
              details: Text(filters.genres.statusLabel),
              suffix: const Icon(FLucideIcons.chevronRight),
              style: .delta(contentStyle: .delta(middleSpacing: 16)),
              onPress: () => context.push('/settings/select-genre-filters'),
            ),
            .tile(
              prefix: const Icon(FLucideIcons.clock),
              title: const Text('Max. Songlänge'),
              details: Text(filters.songLength.statusLabel),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => showFSheet(
                context: context,
                side: FLayout.btt,
                mainAxisMaxRatio: 4 / 5,
                style: .delta(
                  barrierFilter: (_, animation) => .compose(
                    outer: ImageFilter.blur(
                      sigmaX: animation * 5,
                      sigmaY: animation * 5,
                    ),
                    inner: ColorFilter.mode(
                      context.theme.colors.barrier,
                      .srcOver,
                    ),
                  ),
                ),
                useSafeArea: true,
                useRootNavigator: true,
                builder: (sheetContext) => FilterSongLengthSheet(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SettingSlider(
          label: 'Valence',
          min: -1,
          max: 1,
          initialValue: filters.valence.value,
          showSwitch: true,
          switchInitialValue: filters.valence.enabled,
          onValueChanged: (value) => save(
            filters.copyWith(
              valence: FeatureFilter(value, filters.valence.enabled),
            ),
          ),
          onSwitchChanged: (enabled) =>
              save(filters.copyWith(valence: FeatureFilter(0.0, enabled))),
        ),
        const SizedBox(height: 12),
        SettingSlider(
          label: 'Authenticity',
          min: -1,
          max: 1,
          initialValue: filters.authenticity.value,
          showSwitch: true,
          switchInitialValue: filters.authenticity.enabled,
          onValueChanged: (value) => save(
            filters.copyWith(
              authenticity: FeatureFilter(value, filters.authenticity.enabled),
            ),
          ),
          onSwitchChanged: (enabled) =>
              save(filters.copyWith(authenticity: FeatureFilter(0.0, enabled))),
        ),
        const SizedBox(height: 12),
        SettingSlider(
          label: 'Timeliness',
          min: -1,
          max: 1,
          initialValue: filters.timeliness.value,
          showSwitch: true,
          switchInitialValue: filters.timeliness.enabled,
          onValueChanged: (value) => save(
            filters.copyWith(
              timeliness: FeatureFilter(value, filters.timeliness.enabled),
            ),
          ),
          onSwitchChanged: (enabled) =>
              save(filters.copyWith(timeliness: FeatureFilter(0.0, enabled))),
        ),
        const SizedBox(height: 12),
        SettingSlider(
          label: 'Complexity',
          min: -1,
          max: 1,
          initialValue: filters.complexity.value,
          showSwitch: true,
          switchInitialValue: filters.complexity.enabled,
          onValueChanged: (value) => save(
            filters.copyWith(
              complexity: FeatureFilter(value, filters.complexity.enabled),
            ),
          ),
          onSwitchChanged: (enabled) =>
              save(filters.copyWith(complexity: FeatureFilter(0.0, enabled))),
        ),
        const SizedBox(height: 12),
        SettingSlider(
          label: 'Danceability',
          min: -1,
          max: 1,
          initialValue: filters.danceability.value,
          showSwitch: true,
          switchInitialValue: filters.danceability.enabled,
          onValueChanged: (value) => save(
            filters.copyWith(
              danceability: FeatureFilter(value, filters.danceability.enabled),
            ),
          ),
          onSwitchChanged: (enabled) =>
              save(filters.copyWith(danceability: FeatureFilter(0.0, enabled))),
        ),
        const SizedBox(height: 12),
        SettingSlider(
          label: 'Tonal',
          min: -1,
          max: 1,
          initialValue: filters.tonal.value,
          showSwitch: true,
          switchInitialValue: filters.tonal.enabled,
          onValueChanged: (value) => save(
            filters.copyWith(
              tonal: FeatureFilter(value, filters.tonal.enabled),
            ),
          ),
          onSwitchChanged: (enabled) =>
              save(filters.copyWith(tonal: FeatureFilter(0.0, enabled))),
        ),
        const SizedBox(height: 12),
        SettingSlider(
          label: 'Voice',
          min: -1,
          max: 1,
          initialValue: filters.voice.value,
          showSwitch: true,
          switchInitialValue: filters.voice.enabled,
          onValueChanged: (value) => save(
            filters.copyWith(
              voice: FeatureFilter(value, filters.voice.enabled),
            ),
          ),
          onSwitchChanged: (enabled) =>
              save(filters.copyWith(voice: FeatureFilter(0.0, enabled))),
        ),
      ],
    );
  }
}
