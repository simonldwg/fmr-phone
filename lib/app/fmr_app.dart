import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../core/theme/theme.dart';
import 'router.dart';

class FMRPhoneApp extends ConsumerWidget {
  const FMRPhoneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    // TODO: replace with your application's supported locales.
    supportedLocales: FLocalizations.supportedLocales,
    // TODO: add your application's localizations delegates.
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    theme: lightTheme.toApproximateMaterialTheme(),
    darkTheme: darkTheme.toApproximateMaterialTheme(),
    builder: (context, child) => FTheme(
      data: Theme.brightnessOf(context) == .light ? lightTheme : darkTheme,
      child: FToaster(child: FTooltipGroup(child: child!)),
    ),
    routerConfig: ref.watch(routerProvider),
  );
}
