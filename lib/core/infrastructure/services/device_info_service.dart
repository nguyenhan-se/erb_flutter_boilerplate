import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info_service.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceInfo> deviceInfo(DeviceInfoRef ref) async {
  return DeviceInfo.fromPlatform();
}

class DeviceInfo {
  static const _androidIdPlugin = AndroidId();

  String? appVersion;
  String? technology;
  String? osName;
  String? osVersion;
  String? deviceType;
  String? deviceTypeModel;
  String? deviceId;

  DeviceInfo({
    this.appVersion,
    this.technology,
    this.osName,
    this.osVersion,
    this.deviceType,
    this.deviceTypeModel,
    this.deviceId,
  });

  static fromPlatform() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfo deviceInfo;

    if (kIsWeb) {
      var webBrowserInfo = await DeviceInfoPlugin().webBrowserInfo;
      deviceInfo = DeviceInfo(
        osName: webBrowserInfo.platform,
        deviceType: webBrowserInfo.browserName.name,
        deviceTypeModel: webBrowserInfo.userAgent,
        technology: "FlutterWeb",
      );
    } else {
      if (Platform.isAndroid) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        deviceInfo = DeviceInfo(
          osName: "Android ${androidInfo.version.release}",
          osVersion: androidInfo.version.sdkInt.toString(),
          deviceType: androidInfo.manufacturer,
          deviceTypeModel: androidInfo.model,
          deviceId: await _androidIdPlugin.getId(),
        );
      } else if (Platform.isIOS) {
        var iosInfo = await DeviceInfoPlugin().iosInfo;
        deviceInfo = DeviceInfo(
          osName: iosInfo.systemName,
          osVersion: iosInfo.systemVersion,
          deviceTypeModel: iosInfo.name,
          deviceType: iosInfo.model,
          deviceId: iosInfo.identifierForVendor,
        );
      } else {
        deviceInfo = DeviceInfo();
      }
    }

    return deviceInfo
      ..technology ??= "ERbFlutter"
      ..appVersion = "${packageInfo.version}+${packageInfo.buildNumber}";
  }
}
