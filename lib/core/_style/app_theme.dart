import 'package:erb_ui/theme.dart';
import 'package:flutter/material.dart';

part 'app_text_theme.dart';
part 'app_color_scheme.dart';

class AppTheme {
  AppTheme({
    required this.brightness,
    required double fontSizeDelta,
  }) : _fontSizeDelta = fontSizeDelta {
    text = AppTextTheme(
      brightness: brightness,
      fontSizeDelta: fontSizeDelta,
    );

    _setupThemeData();
  }

  final double _fontSizeDelta;
  final Brightness brightness;
  late final AppTextTheme text;
  late final ThemeData themeData;

  void _setupThemeData() {
    final isDark = brightness == Brightness.dark;

    final colorScheme = isDark ? defDarkScheme : defLightScheme;

    final ERbColorScheme eRbColorScheme = isDark
        ? const DefaultERbColorScheme.dark().copyWith()
        : const DefaultERbColorScheme.light().copyWith();

    final theme = ERbTheme(
      colorScheme: colorScheme,
      eRbColorScheme: eRbColorScheme,
    );

    themeData = theme.data.copyWith(
      textTheme: text.textTheme,
      iconTheme: IconThemeData(
        opacity: 1,
        size: 20 + _fontSizeDelta,
      ),
    );
  }
}
