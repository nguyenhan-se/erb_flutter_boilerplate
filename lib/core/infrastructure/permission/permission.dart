import 'package:permission_handler/permission_handler.dart';

import 'permission_base.dart';

export 'permission_base.dart';
export 'package:app_settings/app_settings.dart' show AppSettingsType;
export 'package:permission_handler/permission_handler.dart'
    show PermissionStatus;

/// Represents Camera Permission.
class CameraPermission extends PermissionBase {
  CameraPermission() : super(permission: Permission.camera);
}

/// Represents Camera Permission.
class NotificationPermission extends PermissionBase {
  NotificationPermission() : super(permission: Permission.notification);

  @override
  Future<bool> get isGranted async {
    final status = await permission.status;
    return status.isGranted;
  }
}
