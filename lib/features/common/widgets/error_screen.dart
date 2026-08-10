import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class ErrorScreen extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPress;
  const ErrorScreen({
    required this.title,
    required this.description,

    required this.onPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: context.theme.colors.destructive.withValues(
                alpha: 0.1,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              FLucideIcons.triangleAlert,
              size: 40,
              color: context.theme.colors.destructive,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: context.theme.typography.display.xl.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colors.foreground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: .center,
            style: context.theme.typography.body.sm,
          ),
          const SizedBox(height: 24),
          FButton(
            onPress: onPress,
            mainAxisSize: .min,
            prefix: const Icon(FLucideIcons.rotateCcw),
            child: const Text('Erneut versuchen'),
          ),
        ],
      ),
    );
  }
}
