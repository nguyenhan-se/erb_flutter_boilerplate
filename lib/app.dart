import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/infrastructure/services/app_env_service.dart';
import 'core/features/app_settings/application/application.dart';

/// The main app widget at the root of the widget tree.
class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsServiceProvider);
    final appEnv = ref.watch(appEnvServiceProvider);

    final materialApp = MaterialApp(
      title: 'Flutter Demo',
      theme: ref.watch(lightThemeProvider).themeData,
      darkTheme: ref.watch(darkThemeProvider).themeData,
      themeMode: ref.watch(currentAppThemeModeProvider),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:  ${appEnv.baseUrl}',
              ),
              ElevatedButton(
                  onPressed: () => ref
                      .read(appSettingsServiceProvider.notifier)
                      .toggleDarkMode(),
                  child: const Text('Toggle theme')),
              ERbElevatedButton(
                  enableGradient: true,
                  blockButton: true,
                  onPressed: () => ref
                      .read(appSettingsServiceProvider.notifier)
                      .toggleDarkMode(),
                  position: ERbPosition.end,
                  icon: const Icon(
                    Icons.audiotrack,
                    size: 30.0,
                  ),
                  label: 'Toggle theme'),
              ERbOutlineGradientButton(
                strokeWidth: 3,
                onTap: () => ref
                    .read(appSettingsServiceProvider.notifier)
                    .toggleDarkMode(),
                label: 'Toggle theme',
                // child: const Text('Toggle theme'),
              ),
              const ERbTextField(
                labelText: 'Hello world',
                helpText: 'asdasd',
                hasAsterisk: true,
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
