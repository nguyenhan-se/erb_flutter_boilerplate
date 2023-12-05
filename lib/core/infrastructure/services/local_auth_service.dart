import 'package:erb_shared/utils.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
// ignore: library_prefixes
import 'package:local_auth/error_codes.dart' as localAuthErrorCode;

import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

enum LocalAuthenticationOption {
  face,
  faceId,
  fingerprint,
  touchId,
  none,
}

class LocalAuthenticationService {
  LocalAuthenticationService();

  static final _auth = LocalAuthentication();

  static bool get isPlatformSupported => isAndroid || isIOS || isWindows;

  static Future<bool> get isDeviceSupported async {
    if (!isPlatformSupported) return false;
    return await _auth.isDeviceSupported();
  }

  static Future<bool> get isAvail async {
    if (!isPlatformSupported) return false;

    if (!await _auth.canCheckBiometrics) {
      return false;
    }

    final biometrics = await _auth.getAvailableBiometrics();

    /// [biometrics] on Android and Windows is returned with error
    /// Handle it specially
    if (isAndroid | isWindows) return biometrics.isNotEmpty;
    return biometrics.contains(BiometricType.face) ||
        biometrics.contains(BiometricType.fingerprint);
  }

  static Future<LocalAuthenticationOption> get localAuthenticationOption async {
    final availableBiometrics = await _auth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      return isIOS
          ? LocalAuthenticationOption.faceId
          : LocalAuthenticationOption.face;
    }
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return isIOS
          ? LocalAuthenticationOption.touchId
          : LocalAuthenticationOption.fingerprint;
    }
    return LocalAuthenticationOption.none;
  }

  static Future<bool> authenticate([String? localizedReason]) async {
    if (!await isDeviceSupported) return false;
    try {
      final isAuth = await _auth.authenticate(
        localizedReason: localizedReason ?? 'Auth required',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return isAuth;
    } on PlatformException catch (error) {
      if (error.code == localAuthErrorCode.lockedOut ||
          error.code == localAuthErrorCode.permanentlyLockedOut) {
        throw LocalServiceException(
            kind: LocalServiceExceptionKind.biometric,
            message: error.message ?? 'Unknown error');
      }

      await _auth.stopAuthentication();
      return false;
    }
  }
}
