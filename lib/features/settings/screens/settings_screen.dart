import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

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
                ERbSettingsTile.navigation(
                  leading: const Icon(Icons.backup_outlined),
                  title: const Text('Backup'),
                  value: const Text('On'),
                  onPressed: (context) {},
                ),
                ERbSettingsTile.switchTile(
                  leading: const Icon(Icons.notification_important_rounded),
                  title: const Text('Notification'),
                  initialValue: false,
                  onToggle: (bool value) {},
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
          ],
        ),
      ),
    );
  }
}
