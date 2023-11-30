import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/permission_settings_repo.dart';
import '../domain/permission_settings.dart';

part 'permission_settings_service.g.dart';

@riverpod
class PermissionSettingsService extends _$PermissionSettingsService {
  late PermissionSettingsRepo _permissionSettingsRepo;

  @override
  PermissionSettings build() {
    _permissionSettingsRepo = ref.watch(permissionSettingsRepoProvider);
    final permissionSettings = _permissionSettingsRepo.getPermissionSettings();
    return permissionSettings ?? const PermissionSettings();
  }

  void toggleNotificationEnabled([bool? value]) {
    final currentEnabled = state.isNotificationsEnabled;
    final newSettings =
        state.copyWith(isNotificationsEnabled: value ?? !currentEnabled);
    state = newSettings;
    _permissionSettingsRepo.savePermissionSettings(newSettings);
  }

  Future<void> reset() => _permissionSettingsRepo.clear();
}
