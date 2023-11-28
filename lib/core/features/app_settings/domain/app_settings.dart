import 'package:dart_mappable/dart_mappable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'app_settings.mapper.dart';
part 'app_settings.g.dart';

@MappableClass()
@HiveType(typeId: 1)
class AppSettings with AppSettingsMappable {
  @MappableField()
  @HiveField(0)
  final bool bannerEnabled;

  @MappableField()
  @HiveField(1)
  final bool darkMode;

  @MappableField()
  @HiveField(2)
  final bool systemThemeMode;

  @MappableField()
  @HiveField(3)
  final String locale;

  const AppSettings({
    this.bannerEnabled = true,
    this.darkMode = false,
    this.systemThemeMode = false,
    this.locale = '',
  });

  static const fromJson = AppSettingsMapper.fromJson;
}
