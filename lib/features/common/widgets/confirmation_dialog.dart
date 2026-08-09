import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class VerticalDialog extends StatelessWidget {
  final FDialogStyleDelta style;
  final Animation<double>? animation;
  final Widget title;
  final Widget body;
  final List<Widget> actions;

  const VerticalDialog({
    required this.title,
    required this.body,
    required this.actions,
    this.style = const .context(),
    this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => FDialog(
    style: style,
    animation: animation,
    builder: (context, style) {
      return Padding(
        padding: const .symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Padding(
              padding: const .only(left: 8, right: 8, bottom: 9),
              child: DefaultTextStyle.merge(
                style: style.titleTextStyle,
                child: title,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const .only(left: 8, right: 8, bottom: 20),
                child: DefaultTextStyle.merge(
                  style: style.bodyTextStyle,
                  child: body,
                ),
              ),
            ),
            Column(mainAxisSize: .min, spacing: 10, children: actions),
          ],
        ),
      );
    },
  );
}

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmText = 'Weiter',
  String cancelText = 'Abbrechen',
  bool destructive = false,
}) async {
  final result = await showFDialog<bool>(
    context: context,
    builder: (context, style, animation) => VerticalDialog(
      style: style,
      animation: animation,
      title: Text(title),
      body: Text(message),
      actions: [
        FButton(
          size: .sm,
          variant: destructive ? .destructive : .primary,
          onPress: () => context.pop(true),
          child: Text(confirmText),
        ),
        FButton(
          size: .sm,
          variant: .outline,
          onPress: () => context.pop(false),
          child: Text(cancelText),
        ),
      ],
    ),
  );
  return result ?? false;
}
