import 'package:erb_ui/src/theme/color_scheme/default_color_scheme.dart';
import 'package:flutter/material.dart';

import 'color_scheme/color_scheme.dart';
import 'radius_scheme.dart';
import 'spacing_scheme.dart';

class ERbTheme {
  final ERbSpacingScheme spacingScheme;
  final ERbRadiusScheme radiusScheme;
  final ERbColorScheme eRbColorScheme;

  late final ThemeData data;

  ERbTheme({
    required ColorScheme colorScheme,
    this.spacingScheme = const ERbSpacingScheme.fallback(),
    this.radiusScheme = const ERbRadiusScheme.fallback(),
    this.eRbColorScheme = const DefaultERbColorScheme.light(),
  }) {
    data = ThemeData.from(colorScheme: colorScheme).copyWith(
      splashFactory: NoSplash.splashFactory,
      dividerTheme: const DividerThemeData(thickness: 1, space: 1),
      cardTheme: CardTheme(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
          side: BorderSide(color: colorScheme.outline),
        ),
        surfaceTintColor: colorScheme.surface,
      ),
      chipTheme: ChipThemeData(
        selectedColor: colorScheme.primaryContainer,
      ),
      bottomSheetTheme:
          const BottomSheetThemeData(surfaceTintColor: Colors.transparent),
      inputDecorationTheme: InputDecorationTheme(
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
          color: colorScheme.onBackground,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          visualDensity: VisualDensity.standard,
          padding: EdgeInsets.symmetric(
            vertical: spacingScheme.m,
            horizontal: spacingScheme.l,
          ),
          shape: const StadiumBorder(),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          visualDensity: VisualDensity.standard,
          padding: EdgeInsets.symmetric(
            vertical: spacingScheme.m,
            horizontal: spacingScheme.l,
          ),
          shape: const StadiumBorder(),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size.zero,
          visualDensity: VisualDensity.standard,
          padding: EdgeInsets.symmetric(
            vertical: spacingScheme.m,
            horizontal: spacingScheme.l,
          ),
          shape: const StadiumBorder(),
        ),
      ),
      dialogTheme: DialogTheme(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radiusScheme.large),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surface,
        shadowColor: Colors.black,
        elevation: 10,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: eRbColorScheme.surfaceContainer,
        surfaceTintColor: eRbColorScheme.surfaceContainer,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
          fontSize: 14,
        ),
      ),
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
