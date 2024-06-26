import 'package:flutter/material.dart';

import 'theme.dart';

class ERbThemeData {
  final ERbSpacingScheme spacingScheme;
  final ERbRadiusScheme radiusScheme;
  final ERbColorScheme eRbColorScheme;
  final ColorScheme colorScheme;

  ERbThemeData({
    required this.colorScheme,
    this.spacingScheme = const ERbSpacingScheme.fallback(),
    this.radiusScheme = const ERbRadiusScheme.fallback(),
    this.eRbColorScheme = const DefaultERbColorScheme.light(),
  });

  DividerThemeData get dividerThemeData =>
      const DividerThemeData(thickness: 1, space: 1);

  CardTheme get cardThemeData => CardTheme(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
          side: BorderSide(color: colorScheme.outline),
        ),
        surfaceTintColor: colorScheme.surface,
      );

  ChipThemeData get chipThemeData => ChipThemeData(
        selectedColor: colorScheme.primaryContainer,
      );

  BottomSheetThemeData get bottomSheetThemeData =>
      const BottomSheetThemeData(surfaceTintColor: Colors.transparent);

  InputDecorationTheme get inputDecorationThemeData => InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          vertical: spacingScheme.m,
          horizontal: spacingScheme.l,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(.12)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: colorScheme.onSurface,
        ),
      );

  TextButtonThemeData get textButtonThemeData => TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          visualDensity: VisualDensity.standard,
          padding: EdgeInsets.symmetric(
            vertical: spacingScheme.m,
            horizontal: spacingScheme.l,
          ),
          shape: const StadiumBorder(),
        ),
      );

  ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          visualDensity: VisualDensity.standard,
          padding: EdgeInsets.symmetric(
            vertical: spacingScheme.m,
            horizontal: spacingScheme.l,
          ),
          shape: const StadiumBorder(),
        ),
      );

  OutlinedButtonThemeData get outlinedButtonThemeData =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size.zero,
          visualDensity: VisualDensity.standard,
          padding: EdgeInsets.symmetric(
            vertical: spacingScheme.m,
            horizontal: spacingScheme.l,
          ),
          shape: const StadiumBorder(),
        ),
      );

  DialogTheme get dialogThemeData => DialogTheme(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
        ),
      );

  NavigationBarThemeData get navigationBarThemeData => NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surface,
        shadowColor: Colors.black,
        elevation: 10,
      );

  AppBarTheme get appBarThemeData => AppBarTheme(
        backgroundColor: eRbColorScheme.surfaceContainer,
        surfaceTintColor: eRbColorScheme.surfaceContainer,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
          fontSize: 14,
        ),
      );
}
