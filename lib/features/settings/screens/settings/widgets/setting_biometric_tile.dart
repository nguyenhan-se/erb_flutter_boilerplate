import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:erb_shared/extensions.dart';

import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/features/authentication/application/application.dart';

class SettingBiometricTile extends ERbSettingsTile {
  SettingBiometricTile({
    super.key,
  }) : super(title: const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return HookConsumer(builder: (context, ref, child) {
      final t = useI18n();

      final authBiometricSetting = ref.watch(authBiometricServiceProvider);

      final isBiometricEnabled = useMemoized(() {
        final authSetting = authBiometricSetting.valueOrNull;
        if (authSetting.isNull) return false;
        return authSetting!.isBiometricEnabled;
      }, [authBiometricSetting]);

      final isBiometricSupported = useMemoized(() {
        final authSetting = authBiometricSetting.valueOrNull;
        if (authSetting.isNull) return false;

        return authSetting!.isBiometricSupported;
      }, [authBiometricSetting]);

      return ERbSettingsTile.switchTile(
        leading: const Icon(Icons.lock),
        title: Text(t.featureSettings.auth.authBiometric),
        initialValue: isBiometricEnabled,
        enabled: isBiometricSupported,
        onToggle: (bool value) async {
          await ref
              .read(authBiometricServiceProvider.notifier)
              .toggleBiometricEnabled();
        },
      );
    });
  }
}
