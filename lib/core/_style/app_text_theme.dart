part of 'app_theme.dart';

const kFontFamily = 'Averta';

class AppTextTheme {
  final Brightness _brightness;
  final double _fontSizeDelta;

  late final TextTheme textTheme;

  AppTextTheme({
    required Brightness brightness,
    required double fontSizeDelta,
  })  : _brightness = brightness,
        _fontSizeDelta = fontSizeDelta {
    _setupTextTheme();
  }

  void _setupTextTheme() {
    final typography = _brightness == Brightness.light
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    textTheme = typography.merge(TextTheme(
      // headline1
      displayLarge: applyFontFamily(
        const TextStyle(
          fontSize: 64,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w300,
        ),
      ),
      // headline2
      displayMedium: applyFontFamily(
        const TextStyle(
          fontSize: 48,
          letterSpacing: 1.3,
          fontWeight: FontWeight.w300,
        ),
      ),
      // headline3
      displaySmall: applyFontFamily(
        const TextStyle(
          fontSize: 48,
          letterSpacing: 0,
        ),
      ),
      // headline4
      headlineMedium: applyFontFamily(
        const TextStyle(
          fontSize: 18,
          letterSpacing: 1.3,
          fontWeight: FontWeight.w300,
        ),
      ),
      // headline5
      headlineSmall: applyFontFamily(
        const TextStyle(
          fontSize: 20,
          letterSpacing: 1.3,
          fontWeight: FontWeight.w300,
        ),
      ),
      // headline6
      titleLarge: applyFontFamily(
        const TextStyle(
          fontSize: 20,
          letterSpacing: 1.3,
          fontWeight: FontWeight.w300,
        ),
      ),
      // subtitle1
      titleMedium: applyFontFamily(
        const TextStyle(
          fontSize: 16,
          letterSpacing: 1,
          fontWeight: FontWeight.w300,
        ),
      ),
      // subtitle2
      titleSmall: applyFontFamily(
        const TextStyle(
          height: 1.1,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
      // bodyText1
      bodyLarge: applyFontFamily(
        const TextStyle(
          fontSize: 14,
        ),
      ),
      // bodyText2
      bodyMedium: applyFontFamily(
        const TextStyle(
          fontSize: 16,
        ),
      ),
      // button
      labelLarge: applyFontFamily(
        const TextStyle(
          fontSize: 16,
          letterSpacing: 1.2,
        ),
      ),
      // caption
      bodySmall: applyFontFamily(
        const TextStyle(
          fontSize: 12,
          letterSpacing: .4,
        ),
      ),
      // overline
      labelSmall: applyFontFamily(
        const TextStyle(
          fontSize: 10,
          letterSpacing: 1.5,
        ),
      ),
    ).apply(
      fontSizeDelta: _fontSizeDelta,
    ));
  }
}

TextStyle applyFontFamily(TextStyle textStyle) {
  return textStyle.copyWith(fontFamily: kFontFamily);
}
