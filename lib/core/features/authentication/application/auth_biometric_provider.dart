import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/presentation/utils/fp_framework.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/local_auth_service.dart';

import '../data/auth_biometric_setting_repo.dart';
import '../data/auth_pass_repo.dart';
import '../domain/auth_biometric_setting.dart';
import '../domain/auth_pass.dart';
import '../presentation/screens/sign_in/sign_in_controller.dart';
import 'auth_state_provider.dart';

part 'auth_biometric_provider.g.dart';

@riverpod
class AuthBiometricService extends _$AuthBiometricService {
  late AuthBiometricSettingRepo _authBiometricSetingRepo;
  late AuthPassRepo _authPassRepo;

  @override
  Future<AuthBiometricSetting> build() async {
    _authBiometricSetingRepo = ref.watch(authBiometricSettingRepoProvider);
    _authPassRepo = ref.watch(authPassRepoProvider);

    final authBiometricSetting =
        _authBiometricSetingRepo.getBiometricSettings() ??
            AuthBiometricSetting.empty();
    final isBiometricSupported =
        await LocalAuthenticationService.isDeviceSupported;

    if (isBiometricSupported) {
      ref.listen(
        signInEventProvider,
        (_, nextEvent) {
          nextEvent.match(() => unit, (signInParams) async {
            final auth = ref.read(authStateProvider);
            auth.match(() => unit, (data) async {
              try {
                final currentAuthPass =
                    await ref.read(authPassRepoProvider).getCacheAuthPass();

                if (currentAuthPass.username != signInParams.username) {
                  resetBiometric();
                }
              } catch (_) {}

              // maybe should handle more detail after cache auth
              _authPassRepo.cacheAuthPass(
                AuthPass(
                    username: signInParams.username,
                    password: signInParams.password),
              );
            });
          });
        },
      );
    }

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

  Future<void> resetBiometric() async {
    _authBiometricSetingRepo.clear().then((value) => ref.invalidateSelf());
  }
}
