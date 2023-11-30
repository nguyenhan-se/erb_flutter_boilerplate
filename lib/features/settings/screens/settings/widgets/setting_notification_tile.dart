import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';

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
      final isGoAppSetting = useState(false);

      useOnAppLifecycleStateChange((previous, current) async {
        if (current == AppLifecycleState.resumed && isGoAppSetting.value) {
          final isGranted = await (NotificationPermission().isGranted);
          ref
              .read(permissionSettingsServiceProvider.notifier)
              .toggleNotificationEnabled(isGranted);
          isGoAppSetting.value = false;
        }
      });

      return ERbSettingsTile.switchTile(
        leading: const Icon(Icons.notification_important_rounded),
        title: Text(t.featureSettings.notification),
        initialValue: ref.watch(permissionSettingsServiceProvider
            .select((permission) => permission.isNotificationsEnabled)),
        onToggle: (bool value) async {
          if (!value) {
            Dialogs.showAlertDialog(
              context,
              message: 'Are you sure?',
              dialogType: DialogType.success,
              onPressed: () {
                ref
                    .read(permissionSettingsServiceProvider.notifier)
                    .toggleNotificationEnabled();
              },
            );
          } else {
            final notificationPermission = NotificationPermission();
            final permission = await notificationPermission.request();
            if (permission == PermissionStatus.permanentlyDenied &&
                context.mounted) {
              Dialogs.showAlertAppSettingDialog(
                context,
                reason: t.system.requestPermissionMsg.notification,
                onGoAppSetting: () {
                  isGoAppSetting.value = true;
                },
              );
            }
          }
        },
      );
    });
  }
}
