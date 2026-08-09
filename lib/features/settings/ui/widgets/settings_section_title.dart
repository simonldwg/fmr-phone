import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle(this.title, {super.key, this.smallSize = false});

  final String title;
  final bool smallSize;

  @override
  Widget build(BuildContext context) {
    final font = (smallSize)
        ? context.theme.typography.display.sm
        : context.theme.typography.display.md;
    final padding = EdgeInsets.only(bottom: 12);

    return Padding(
      padding: padding,
      child: Text(title, style: font.copyWith(fontWeight: FontWeight.w600)),
    );
  }
}
