import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/permission_settings.dart';

part 'permission_settings_repo.g.dart';

@riverpod
PermissionSettingsRepo permissionSettingsRepo(PermissionSettingsRepoRef ref) {
  final box = Hive.box<PermissionSettings>(PermissionSettingsRepo.key);

  return PermissionSettingsRepo(box);
}

class PermissionSettingsRepo {
  PermissionSettingsRepo(this.box);

  static const String key = 'permissionSettings';

  final Box<PermissionSettings> box;

  void savePermissionSettings(PermissionSettings permissionSettings) {
    box.put(key, permissionSettings);
  }

  PermissionSettings? getPermissionSettings() {
    final permissionSettingsJson = box.get(key);
    return permissionSettingsJson;
  }

  Future<void> clear() => box.clear();

  static Future<void> prepare() async {
    await Hive.openBox<PermissionSettings>(key);
  }
}
