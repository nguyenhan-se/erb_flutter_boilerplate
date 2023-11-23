import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/app_settings_repo.dart';
import '../domain/app_settings.dart';

part 'app_settings_service.g.dart';

@riverpod
class AppSettingsService extends _$AppSettingsService {
  late AppSettingsRepo _appSettingsRepo;

  @override
  AppSettings build() {
    _appSettingsRepo = ref.watch(appSettingsRepoProvider);
    final settings = _appSettingsRepo.getSettings();
    return settings ?? const AppSettings();
  }

  void toggleBanner() {
    final bannerEnabled = state.bannerEnabled;
    final newSettings = state.copyWith(bannerEnabled: !bannerEnabled);
    state = newSettings;
    _appSettingsRepo.saveSettings(newSettings);
  }

  void toggleDarkMode() {
    final darkMode = state.darkMode;
    final newSettings = state.copyWith(darkMode: !darkMode);
    state = newSettings;
    _appSettingsRepo.saveSettings(newSettings);
  }

  void toggleSystemThemeMode() {
    final systemThemeMode = state.systemThemeMode;
    final newSettings = state.copyWith(systemThemeMode: !systemThemeMode);
    state = newSettings;
    _appSettingsRepo.saveSettings(newSettings);
  }
}
