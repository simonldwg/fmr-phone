import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SmallDescriptionText extends StatelessWidget {
  final String text;

  const SmallDescriptionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.theme.typography.body.xs.copyWith(
        color: context.theme.colors.mutedForeground,
      ),
    );
  }
}
