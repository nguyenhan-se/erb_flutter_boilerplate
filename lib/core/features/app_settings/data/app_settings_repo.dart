import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/app_settings.dart';

part 'app_settings_repo.g.dart';

@riverpod
AppSettingsRepo appSettingsRepo(AppSettingsRepoRef ref) {
  final box = Hive.box<AppSettings>(AppSettingsRepo.key);

  return AppSettingsRepo(box);
}

class AppSettingsRepo {
  AppSettingsRepo(this.box);

  static const String key = 'appSettings';

  final Box<AppSettings> box;

  void saveSettings(AppSettings settings) {
    box.put(key, settings);
  }

  AppSettings? getSettings() {
    final settingsJson = box.get(key);
    return settingsJson;
  }

  static Future<void> prepare() async {
    await Hive.openBox<AppSettings>(key);
  }
}
