import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/features/app_settings/application/application.dart';

@RoutePage()
class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: ERbSettingsList(
          sections: [
            ERbSettingsSection(
              title: const Text('General'),
              tiles: <ERbSettingsTile>[
                ERbSettingsTile.switchTile(
                  leading: const Icon(Icons.notification_important_rounded),
                  title: const Text('Notification'),
                  initialValue: false,
                  onToggle: (bool value) {},
                ),
                ERbSettingsTile.switchTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: const Text('Theme'),
                  initialValue: ref.watch(isDarkModeProvider),
                  onToggle: (bool value) {
                    ref
                        .watch(appSettingsServiceProvider.notifier)
                        .toggleDarkMode();
                  },
                ),
                ERbSettingsTile.navigation(
                  leading: const Icon(Icons.language_outlined),
                  title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Language'),
                    ],
                  ),
                  value: const Text('en'),
                  onPressed: (context) {},
                ),
              ],
            ),
            ERbSettingsSection(
              title: const Text('Security'),
              tiles: <ERbSettingsTile>[
                ERbSettingsTile.switchTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('User biometrics'),
                  initialValue: false,
                  onToggle: (bool value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
