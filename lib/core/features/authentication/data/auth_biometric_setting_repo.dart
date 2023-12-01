import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/auth_biometric_setting.dart';

part 'auth_biometric_setting_repo.g.dart';

@riverpod
AuthBiometricSettingRepo authBiometricSettingRepo(
    AuthBiometricSettingRepoRef ref) {
  final box = Hive.box<AuthBiometricSetting>(AuthBiometricSettingRepo.key);

  return AuthBiometricSettingRepo(box);
}

class AuthBiometricSettingRepo {
  AuthBiometricSettingRepo(this.box);

  static const String key = 'biometric_setting';

  final Box<AuthBiometricSetting> box;

  void saveBiometricSettings(AuthBiometricSetting settings) {
    box.put(key, settings);
  }

  AuthBiometricSetting? getBiometricSettings() {
    final settingsJson = box.get(key);
    return settingsJson;
  }

  Future<void> clear() => box.clear();

  static Future<void> prepare() async {
    await Hive.openBox<AuthBiometricSetting>(key);
  }
}
