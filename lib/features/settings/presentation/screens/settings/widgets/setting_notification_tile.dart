import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/permission/permission.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/features/app_settings/application/application.dart';

class SettingNotificationTile extends ERbSettingsTile {
  SettingNotificationTile({
    super.key,
  }) : super(title: const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return HookConsumer(builder: (context, ref, child) {
      final t = useI18n();
      final (goAppSetting: goAppSetting) = useGoAppSetting(
        onComeBack: () async {
          final isGranted = await (NotificationPermission().isGranted);
          ref
              .read(permissionSettingsServiceProvider.notifier)
              .toggleNotificationEnabled(isGranted);
        },
      );

      return ERbSettingsTile.switchTile(
        leading: const Icon(Icons.notification_important_rounded),
        title: Text(t.featureSettings.notification.setting),
        initialValue: ref.watch(permissionSettingsServiceProvider
            .select((permission) => permission.isNotificationsEnabled)),
        onToggle: (bool value) async {
          if (!value) {
            Dialogs.showAlertDialog(
              context,
              message: t.featureSettings.notification.turnOffMsg,
              dialogType: DialogType.warning,
              onPressed: () {
                ref
                    .read(permissionSettingsServiceProvider.notifier)
                    .toggleNotificationEnabled();
              },
            );
          } else {
            final notificationPermission = NotificationPermission();
            final isGranted = await notificationPermission.isGranted;
            if (isGranted) {
              ref
                  .read(permissionSettingsServiceProvider.notifier)
                  .toggleNotificationEnabled();
              return;
            }

            final permission = await notificationPermission.request();
            // NOTE: if support web need handle case PermissionStatus.permanentlyDenied
            if (!kIsWeb &&
                context.mounted &&
                permission == PermissionStatus.permanentlyDenied) {
              Dialogs.showRequestPermissionDialog(
                context,
                reason: t.system.requestPermissionMsg.notification,
                onPositiveClick: (context) {
                  goAppSetting(type: AppSettingsType.notification);
                  // ignore: deprecated_member_use
                  AutoRouter.of(context).pop();
                },
              );
            }
          }
        },
      );
    });
  }
}
