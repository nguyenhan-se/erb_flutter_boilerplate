import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionBase {
  PermissionBase({required this.permission});

  /// The underlying permission instance.
  final Permission permission;

  // /// Returns `true` if Permission is granted, otherwise returns `false`.
  // Future<PermissionStatus> check() async {
  //   return permission.status;
  // }

  Future<PermissionStatus> request() async {
    // CASE: Permission is already granted.
    final initialStatus = await permission.status;
    if (initialStatus == PermissionStatus.granted ||
        initialStatus == PermissionStatus.limited) {
      return initialStatus;
    }

    // CASE: Permission is restricted by user by purpose.
    final shouldPromptSettings = (await permission.isPermanentlyDenied) ||
        (await permission.isRestricted);

    if (shouldPromptSettings) {
      await openAppSettings();
      return PermissionStatus.permanentlyDenied;
    } else if (await permission.isDenied) {
      // CASE: Permission is just denied.
      PermissionStatus status = await permission.request();
      if (status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
        return PermissionStatus.permanentlyDenied;
      }
    }

    // Return final status of permission status.
    return await permission.status;
  }

  Future<bool> get isGranted async {
    final status = await permission.status;
    return status.isGranted || status.isLimited;
  }

  /// Opens the App Setting or App Info Page provided by Operating System.
  Future<void> openAppSettings() async {
    await AppSettings.openAppSettings(asAnotherTask: true);
  }
}
