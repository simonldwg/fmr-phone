import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:fitness_music_recommender/features/common/domain/models/genre.dart';
import 'package:go_router/go_router.dart';

import '../../data/settings_controller_provider.dart';

class SelectGenreFiltersPage extends ConsumerStatefulWidget {
  const SelectGenreFiltersPage({super.key});

  @override
  ConsumerState<SelectGenreFiltersPage> createState() =>
      _SelectGenreFiltersPageState();
}

class _SelectGenreFiltersPageState
    extends ConsumerState<SelectGenreFiltersPage> {
  final _formKey = GlobalKey<FormState>();
  late Set<Genre> _selected;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsControllerProvider).requireSettings;
    _selected = settings.filters.genres.toSet();
  }

  Future<void> _save() async {
    final controller = ref.read(settingsControllerProvider);
    await controller.updateWith(
      filters: controller.requireSettings.filters.copyWith(
        genres: _selected.toSet(),
      ),
    );

    if (mounted) context.go('/settings');
  }

  @override
  Widget build(BuildContext context) => FScaffold(
    childPad: false,
    header: FHeader.nested(
      prefixes: [FHeaderAction.back(onPress: () => context.pop())],
      title: const Text('Genre-Filter'),
      titleAlignment: .centerLeft,
    ),
    footer: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FButton(onPress: _save, child: const Text('Speichern')),
      ),
    ),
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wähle die Genres aus, aus denen Musik gespielt werden soll. '
              'Wenn du keine Genres auswählst, wird aus allen Genres Musik '
              'gespielt.',
              style: context.theme.typography.body.xs.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            ),
            const SizedBox(height: 16),
            FSelectGroup<Genre>(
              control: .managed(
                initial: _selected,
                onChange: (all) => setState(() => _selected = all),
              ),
              label: const Text('Genres'),
              children: [
                for (final genre in Genre.values)
                  .checkbox(value: genre, label: Text(genre.label)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
