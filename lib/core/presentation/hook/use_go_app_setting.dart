import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/permission/permission.dart';

typedef UseGoAppSetting<T> = ({
  Function({AppSettingsType? type, bool? asAnotherTask}) goAppSetting,
});

UseGoAppSetting useGoAppSetting({
  VoidCallback? onComeBack,
}) {
  final isGoAppSetting = useState(false);
  useOnAppLifecycleStateChange((previous, current) {
    if (current == AppLifecycleState.resumed && isGoAppSetting.value) {
      onComeBack?.call();
      isGoAppSetting.value = false;
    }
  });

  void goAppSetting({AppSettingsType? type, bool? asAnotherTask}) {
    isGoAppSetting.value = true;
    unawaited(PermissionBase.openAppSettings(
      type: type,
      asAnotherTask: asAnotherTask,
    ));
  }

  return (goAppSetting: goAppSetting);
}
