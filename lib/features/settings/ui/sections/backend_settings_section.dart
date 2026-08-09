import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../data/settings_controller_provider.dart';

class BackendSettingsSection extends ConsumerWidget {
  const BackendSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsController = ref.watch(settingsControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FTileGroup(
          label: const Text('Backend'),
          children: [
            .tile(
              prefix: const Icon(FLucideIcons.link),
              title: const Text('API-URL'),
              details: Text(settingsController.requireSettings.apiUrl),
              suffix: const Icon(FLucideIcons.chevronRight),
              onPress: () => context.push('/settings/api-url'),
            ),
          ],
        ),
      ],
    );
  }
}
