import 'package:flutter/material.dart';

import 'color_scheme/color_scheme.dart';
import 'color_scheme/default_color_scheme.dart';
import 'erb_theme_data.dart';
import 'radius_scheme.dart';
import 'spacing_scheme.dart';

class ERbTheme {
  final ERbSpacingScheme spacingScheme;
  final ERbRadiusScheme radiusScheme;
  final ERbColorScheme eRbColorScheme;
  final ColorScheme colorScheme;

  late final ThemeData data;

  ERbThemeData get eRbThemeData => ERbThemeData(
        colorScheme: colorScheme,
        eRbColorScheme: eRbColorScheme,
        radiusScheme: radiusScheme,
        spacingScheme: spacingScheme,
      );

  ERbTheme({
    required this.colorScheme,
    this.spacingScheme = const ERbSpacingScheme.fallback(),
    this.radiusScheme = const ERbRadiusScheme.fallback(),
    this.eRbColorScheme = const DefaultERbColorScheme.light(),
  }) {
    data = ThemeData.from(colorScheme: colorScheme).copyWith(
      splashFactory: NoSplash.splashFactory,
      dividerTheme: eRbThemeData.dividerThemeData,
      cardTheme: eRbThemeData.cardThemeData,
      chipTheme: eRbThemeData.chipThemeData,
      bottomSheetTheme: eRbThemeData.bottomSheetThemeData,
      inputDecorationTheme: eRbThemeData.inputDecorationThemeData,
      textButtonTheme: eRbThemeData.textButtonThemeData,
      elevatedButtonTheme: eRbThemeData.elevatedButtonThemeData,
      outlinedButtonTheme: eRbThemeData.outlinedButtonThemeData,
      dialogTheme: eRbThemeData.dialogThemeData,
      navigationBarTheme: eRbThemeData.navigationBarThemeData,
      appBarTheme: eRbThemeData.appBarThemeData,
      extensions: [
        spacingScheme,
        radiusScheme,
        eRbColorScheme,
      ],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ERbTheme &&
        other.spacingScheme == spacingScheme &&
        other.radiusScheme == radiusScheme &&
        other.data == data;
  }

  @override
  int get hashCode {
    return spacingScheme.hashCode ^ radiusScheme.hashCode ^ data.hashCode;
  }
}
