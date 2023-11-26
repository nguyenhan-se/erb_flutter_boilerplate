import 'package:permission_handler/permission_handler.dart';

import 'permission_base.dart';

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
