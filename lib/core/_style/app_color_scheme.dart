part of 'app_theme.dart';

class AppStaticColors {
  static const Color primary = Color(0xFF0022B1);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEFF6FF);
  static const Color onPrimaryContainer = Color(0xFF0022B1);
  static const Color secondary = Color(0xFFFEE05A);
  static const Color onSecondary = Color(0xFF33343B);
  static const Color secondaryContainer = Color(0xFFFFFBEA);
  static const Color onSecondaryContainer = Color(0xFF33343B);
  static const Color tertiary = Color(0xFF17A750);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFF4FEF8);
  static const Color onTertiaryContainer = Color(0xFF17A750);
  static const Color error = Color(0xFFE22929);
  static const Color errorContainer = Color(0xFFFFEEEE);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF33343B);
  static const Color background = Color(0xFFFFFEFB);
  static const Color onBackground = Color(0xFF33343B);
  static const Color outline = Color(0xFFF9F6F0);
  static const Color onInverseSurface = Color(0xFFFFFFFF);
  static const Color inverseSurface = Color(0xFF33343B);
  static const Color inversePrimary = Color(0xFFEFF6FF);
  static const Color shadow = Color(0xFF000000);
  static const Color surfaceTint = Color(0xFF3A4FD4);
  static const Color outlineVariant = Color(0xFFB2C6FF);
  static const Color scrim = Color(0xFF000000);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF33343B);
  static const Color surfaceVariant = Color(0xFFFFFEFB);
  static const Color onSurfaceVariant = Color(0xFF686868);

  static const LinearGradient primaryIngredientColor = LinearGradient(
    colors: [
      Color(0xff273E7C),
      Color(0xFF1435EB),
    ],
    stops: [0, 1],
  );
  static const LinearGradient secondaryIngredientColor = LinearGradient(
    colors: [secondary, Color(0xffFF9D44)],
    stops: [0, 1],
  );
}

const defLightScheme = ColorScheme(
  primary: AppStaticColors.primary,
  onPrimary: AppStaticColors.onPrimary,
  primaryContainer: AppStaticColors.primaryContainer,
  onPrimaryContainer: AppStaticColors.onPrimaryContainer,
  secondary: AppStaticColors.secondary,
  onSecondary: AppStaticColors.onSecondary,
  secondaryContainer: AppStaticColors.secondaryContainer,
  onSecondaryContainer: AppStaticColors.onSecondaryContainer,
  tertiary: AppStaticColors.tertiary,
  onTertiary: AppStaticColors.onTertiary,
  tertiaryContainer: AppStaticColors.tertiaryContainer,
  onTertiaryContainer: AppStaticColors.onTertiaryContainer,
  error: AppStaticColors.error,
  errorContainer: AppStaticColors.errorContainer,
  onError: AppStaticColors.onError,
  onErrorContainer: AppStaticColors.onErrorContainer,
  outline: AppStaticColors.outline,
  onInverseSurface: AppStaticColors.onInverseSurface,
  inverseSurface: AppStaticColors.inverseSurface,
  inversePrimary: AppStaticColors.inversePrimary,
  shadow: AppStaticColors.shadow,
  surfaceTint: AppStaticColors.surfaceTint,
  outlineVariant: AppStaticColors.outlineVariant,
  scrim: AppStaticColors.scrim,
  surface: AppStaticColors.surface,
  onSurface: AppStaticColors.onSurface,
  onSurfaceVariant: AppStaticColors.onSurfaceVariant,
  brightness: Brightness.light,
);

final defDarkScheme = ColorScheme.fromSeed(
  seedColor: AppStaticColors.primary,
  secondary: AppStaticColors.onPrimary,
  brightness: Brightness.dark,
);
