import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../common/ widgets/confirmation_dialog.dart';
import '../../data/settings_controller_provider.dart';
import '../widgets/settings_section_title.dart';

class ResetSettingsSection extends ConsumerWidget {
  const ResetSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onReset() async {
      final confirmed = await showConfirmDialog(
        context,
        title: 'App zurücksetzen',
        message:
            'Möchtest du die App wirklich zurücksetzen? Dabei gehen alle Einstellungen verloren. Deine Musik bleibt erhalten.',
        confirmText: 'Zurücksetzen',
        destructive: true,
      );

      if (confirmed) {
        ref.read(settingsControllerProvider).resetToFactoryDefaults();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle('Werkseinstellungen'),
        FTileGroup(
          children: [
            .tile(
              prefix: Icon(
                FLucideIcons.rotateCcw,
                color: context.theme.colors.destructive,
              ),
              title: Text(
                'App zurücksetzen...',
                style: TextStyle(color: context.theme.colors.destructive),
              ),
              onPress: onReset,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Dadurch werden lediglich alle Einstellungen gelöscht. Deine Musik bleibt erhalten.',
          style: context.theme.typography.body.xs.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
