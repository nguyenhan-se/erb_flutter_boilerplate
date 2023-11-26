import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/features/app_settings/application/application.dart';
import 'routes/routes.dart';

/// The main app widget at the root of the widget tree.
class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsServiceProvider);
    final appRouter = ref.watch(appRouterProvider);

    final materialApp = MaterialApp.router(
      title: 'Flutter Demo',
      theme: ref.watch(lightThemeProvider).themeData,
      darkTheme: ref.watch(darkThemeProvider).themeData,
      themeMode: ref.watch(currentAppThemeModeProvider),
      routerConfig: appRouter.config(
        reevaluateListenable: ref.watch(appRouterReevaluateListenableProvider),
        navigatorObservers: () => [AutoRouteObserver()],
      ),
    );

    final bannerEnabled = appSettings.bannerEnabled;
    if (bannerEnabled) {
      return FlavorBanner(
        child: materialApp,
      );
    }
    return materialApp;
  }
}
