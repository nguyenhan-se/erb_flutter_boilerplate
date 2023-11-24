import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/_style/app_theme.dart';

part 'app_theme_service.g.dart';

@riverpod
AppTheme lightTheme(LightThemeRef ref) {
  return AppTheme(brightness: Brightness.light, fontSizeDelta: 0);
}

@riverpod
AppTheme darkTheme(DarkThemeRef ref) {
  return AppTheme(brightness: Brightness.dark, fontSizeDelta: 0);
}
