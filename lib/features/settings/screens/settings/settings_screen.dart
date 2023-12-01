import 'package:erb_flutter_boilerplate/features/settings/screens/settings/section_dev_setting.dart';
import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/features/app_settings/application/application.dart';

import 'widgets/setting_notification_tile.dart';
import 'widgets/setting_signout_tile.dart';

@RoutePage()
class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = useI18n();

    return AppScaffold(
      body: ERbSettingsList(
        sections: [
          ERbSettingsSection(
            title: const Text('General'),
            tiles: [
              SettingNotificationTile(),
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
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(t.featureSettings.language.i18n),
                  ],
                ),
                value: Text(ref.watch(currentLanguageProvider).languageCode),
                onPressed: (context) {
                  AutoRouter.of(context).push(const LanguageSettingRoute());
                },
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
          ERbSettingsSection(
            title: const Text('Account'),
            tiles: <ERbSettingsTile>[
              SettingSignOutTile(),
            ],
          ),
          const SectionDevSetting()
        ],
      ),
    );
  }
}
