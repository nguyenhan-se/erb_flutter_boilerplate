import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:erb_shared/extensions.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/local_auth_service.dart';
import 'package:erb_flutter_boilerplate/core/features/authentication/application/application.dart';

class SettingBiometricTile extends ERbSettingsTile {
  SettingBiometricTile({
    super.key,
  }) : super(title: const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return LocalAuthenticationService.isPlatformSupported
        ? HookConsumer(builder: (context, ref, child) {
            final t = useI18n();
            final (goAppSetting: goAppSetting) = useGoAppSetting(
              onComeBack: () async {
                final isValid = await LocalAuthenticationService.isAvail;
                ref
                    .read(authBiometricServiceProvider.notifier)
                    .toggleBiometricEnabled(isValid);
              },
            );
            final authBiometricSetting =
                ref.watch(authBiometricServiceProvider);

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
              onToggle: (bool enabled) async {
                if (!enabled) {
                  Dialogs.showAlertDialog(
                    context,
                    message: t.featureSettings.auth.turnOffMsg,
                    dialogType: DialogType.warning,
                    onPressed: () {
                      ref
                          .read(authBiometricServiceProvider.notifier)
                          .toggleBiometricEnabled();
                    },
                  );
                } else {
                  final isAvail = await LocalAuthenticationService.isAvail;
                  if (context.mounted && !isAvail) {
                    Dialogs.showRequestPermissionDialog(
                      context,
                      reason: t.system.requestPermissionMsg.biometric,
                      onPositiveClick: (context) {
                        goAppSetting();
                        // ignore: deprecated_member_use
                        AutoRouter.of(context).pop();
                      },
                    );
                  } else {
                    final isAuth =
                        await LocalAuthenticationService.authenticate();
                    if (isAuth) {
                      ref
                          .read(authBiometricServiceProvider.notifier)
                          .toggleBiometricEnabled();
                    }
                  }
                }
              },
            );
          })
        : const SizedBox.shrink();
  }
}
