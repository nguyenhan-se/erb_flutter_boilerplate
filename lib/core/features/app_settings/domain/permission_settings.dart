import 'package:dart_mappable/dart_mappable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'permission_settings.mapper.dart';
part 'permission_settings.g.dart';

@MappableClass()
@HiveType(typeId: 3)
class PermissionSettings with PermissionSettingsMappable {
  @MappableField()
  @HiveField(0)
  final bool isNotificationsEnabled;

  const PermissionSettings({
    this.isNotificationsEnabled = false,
  });

  static const fromJson = PermissionSettingsMapper.fromJson;
}
