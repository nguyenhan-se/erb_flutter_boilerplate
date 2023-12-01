import 'package:hive_flutter/hive_flutter.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'auth_biometric_setting.mapper.dart';
part 'auth_biometric_setting.g.dart';

@MappableClass()
@HiveType(typeId: 4)
class AuthBiometricSetting with AuthBiometricSettingMappable {
  @MappableField()
  @HiveField(0)
  final bool isBiometricEnabled;
  @MappableField()
  @HiveField(1)
  final bool isBiometricSupported;

  const AuthBiometricSetting({
    required this.isBiometricEnabled,
    required this.isBiometricSupported,
  });

  factory AuthBiometricSetting.empty() {
    return const AuthBiometricSetting(
      isBiometricEnabled: false,
      isBiometricSupported: false,
    );
  }

  static const fromJson = AuthBiometricSettingMapper.fromJson;
}
