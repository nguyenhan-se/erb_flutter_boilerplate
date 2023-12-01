import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/services/local_auth_service.dart';

import '../data/auth_biometric_setting_repo.dart';
import '../domain/auth_biometric_setting.dart';

part 'auth_biometric_provider.g.dart';

@riverpod
class AuthBiometricService extends _$AuthBiometricService {
  late AuthBiometricSettingRepo _authBiometricSetingRepo;

  @override
  Future<AuthBiometricSetting> build() async {
    _authBiometricSetingRepo = ref.watch(authBiometricSettingRepoProvider);
    final authBiometricSetting =
        _authBiometricSetingRepo.getBiometricSettings() ??
            AuthBiometricSetting.empty();

    final isBiometricSupported = await LocalAuthenticationService.isAvail;

    return authBiometricSetting.copyWith(
      isBiometricSupported: isBiometricSupported,
    );
  }

  Future<void> toggleBiometricEnabled([bool? value]) async {
    final old = await future;
    final newSettings =
        old.copyWith(isBiometricEnabled: value ?? !old.isBiometricEnabled);
    state = AsyncData(newSettings);
    _authBiometricSetingRepo.saveBiometricSettings(newSettings);
  }
}
