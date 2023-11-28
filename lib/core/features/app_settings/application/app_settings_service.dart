import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/i18n/i18n.dart';

import '../data/app_settings_repo.dart';
import '../domain/app_settings.dart';

part 'app_settings_service.g.dart';

@riverpod
class AppSettingsService extends _$AppSettingsService {
  late AppSettingsRepo _appSettingsRepo;

  @override
  AppSettings build() {
    _appSettingsRepo = ref.watch(appSettingsRepoProvider);
    _appSettingsRepo.box.clear();
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

  void setLocale(AppLocale? locale) {
    final newSettings =
        state.copyWith(locale: locale != null ? locale.name : '');
    state = newSettings;
    _appSettingsRepo.saveSettings(newSettings);
  }
}

@riverpod
bool isDarkMode(IsDarkModeRef ref) {
  final appSettings = ref.watch(appSettingsServiceProvider);
  return appSettings.darkMode;
}

@riverpod
ThemeMode currentAppThemeMode(CurrentAppThemeModeRef ref) {
  final appSettings = ref.watch(appSettingsServiceProvider);
  return appSettings.systemThemeMode
      ? ThemeMode.system
      : appSettings.darkMode
          ? ThemeMode.dark
          : ThemeMode.light;
}

@riverpod
AppLocale? currentLanguage(CurrentLanguageRef ref) {
  final appSettings = ref.watch(appSettingsServiceProvider);

  AppLocale? localeFromStr(String name) {
    try {
      return AppLocale.values.firstWhere((it) => it.name == name);
    } on StateError {
      return null;
    }
  }

  return localeFromStr(appSettings.locale);
}
