import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/features/app_settings/application/app_settings_service.dart';
import 'core/infrastructure/services/app_env_service.dart';

/// The main app widget at the root of the widget tree.
class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsServiceProvider);
    final appEnv = ref.watch(appEnvServiceProvider);

    final materialApp = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      themeMode: appSettings.systemThemeMode
          ? ThemeMode.system
          : appSettings.darkMode
              ? ThemeMode.dark
              : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:  ${appEnv.baseUrl}',
              ),
            ],
          ),
        ),
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
