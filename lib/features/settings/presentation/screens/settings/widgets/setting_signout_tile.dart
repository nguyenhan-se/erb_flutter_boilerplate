import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';

import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/features/authentication/application/application.dart';

class SettingSignOutTile extends ERbSettingsTile {
  SettingSignOutTile({
    super.key,
  }) : super(title: const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return HookConsumer(builder: (context, ref, child) {
      final t = useI18n();

      final isSigned = ref.watch(isSignedProvider);
      final isSignOutProgress = ref.watch(signOutControllerProvider).isLoading;

      final enabled = useMemoized(() {
        if (!isSigned || isSignOutProgress) return false;
        return true;
      }, [isSigned, isSignOutProgress]);

      return ERbSettingsTile(
        leading: const Icon(Icons.notification_important_rounded),
        title: Text(t.featureSettings.account.signout),
        enabled: enabled,
        onPressed: (context) {
          ref.read(signOutControllerProvider.notifier).signOut();
        },
      );
    });
  }
}
