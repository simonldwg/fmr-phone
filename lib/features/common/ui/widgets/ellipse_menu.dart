import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class EllipseMenu extends StatelessWidget {
  const EllipseMenu({required this.menu, required this.buttonSize, super.key});

  final List<FItemGroupMixin> menu;
  final FButtonSizeVariant buttonSize;

  @override
  Widget build(BuildContext context) {
    return FPopoverMenu(
      autofocus: true,
      menuAnchor: .topRight,
      childAnchor: .bottomRight,
      menu: menu,
      builder: (_, controller, _) => FButton.icon(
        variant: .ghost,
        size: buttonSize,
        onPress: controller.toggle,
        child: const Icon(FLucideIcons.ellipsisVertical),
      ),
    );
  }
}
