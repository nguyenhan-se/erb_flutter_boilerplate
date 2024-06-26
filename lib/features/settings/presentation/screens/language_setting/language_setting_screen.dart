import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/i18n/i18n.dart';
import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/features/app_settings/application/app_settings_service.dart';

@RoutePage()
class LanguageSettingScreen extends HookConsumerWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const subtitlePadding = EdgeInsets.only(top: 8);
    final t = useI18n();

    updateLocale(AppLocale? locale) {
      ref.read(appSettingsServiceProvider.notifier).setLocale(locale);
      Future.delayed(
        const Duration(milliseconds: 500),
        // ignore: deprecated_member_use
        () => AutoRouter.of(context).pop(),
      );
    }

    return AppScaffold(
      appBar: AppBar(title: Text(t.featureSettings.language.pickLanguage)),
      body: SafeArea(
        child: ListView(
          children: AppLocale.values.map((locale) {
            return ListTile(
              title: Text(locale.translations.system.languageName),
              subtitle: Padding(
                padding: subtitlePadding,
                child: Text(locale.translations.system.languageAlias),
              ),
              onTap: () {
                updateLocale(locale);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
