import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../features/playback/ui/widgets/mini_player.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => FScaffold(
    childPad: false,
    footer: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const MiniPlayer(),
        FBottomNavigationBar(
          index: navigationShell.currentIndex,
          onChange: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          children: const [
            FBottomNavigationBarItem(
              icon: Icon(FLucideIcons.bike),
              label: Text('Training'),
            ),
            FBottomNavigationBarItem(
              icon: Icon(FLucideIcons.libraryBig),
              label: Text('Bibliothek'),
            ),
            FBottomNavigationBarItem(
              icon: Icon(FLucideIcons.settings),
              label: Text('Einstellungen'),
            ),
          ],
        ),
      ],
    ),
    child: navigationShell,
  );
}
