part of 'app_theme.dart';

const kFontFamily = 'Averta';
const kFontPackageName = 'assets';

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

    textTheme = typography.merge(const TextTheme(
      // headline1
      displayLarge: TextStyle(
        fontSize: 64,
        letterSpacing: 1.6,
        fontWeight: FontWeight.w300,
      ),
      // headline2
      displayMedium: TextStyle(
        fontSize: 48,
        letterSpacing: 1.3,
        fontWeight: FontWeight.w300,
      ),
      // headline3
      displaySmall: TextStyle(
        fontSize: 48,
        letterSpacing: 0,
      ),
      // headline4
      headlineMedium: TextStyle(
        fontSize: 18,
        letterSpacing: 1.3,
        fontWeight: FontWeight.w300,
      ),
      // headline5
      headlineSmall: TextStyle(
        fontSize: 20,
        letterSpacing: 1.3,
        fontWeight: FontWeight.w300,
      ),
      // headline6
      titleLarge: TextStyle(
        fontSize: 20,
        letterSpacing: 1.3,
        fontWeight: FontWeight.w300,
      ),
      // subtitle1
      titleMedium: TextStyle(
        fontSize: 16,
        letterSpacing: 1,
        fontWeight: FontWeight.w300,
      ),
      // subtitle2
      titleSmall: TextStyle(
        height: 1.1,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      // bodyText1
      bodyMedium: TextStyle(fontSize: 14),
      // bodyText2
      bodyLarge: TextStyle(fontSize: 16),
      // button
      labelLarge: TextStyle(
        fontSize: 16,
        letterSpacing: 1.2,
      ),
      // caption
      bodySmall: TextStyle(
        fontSize: 12,
        letterSpacing: .4,
      ),
      // overline
      labelSmall: TextStyle(
        fontSize: 10,
        letterSpacing: 1.5,
      ),
    ).apply(
      fontSizeDelta: _fontSizeDelta,
      fontFamily: kFontFamily,
      package: kFontPackageName,
    ));
  }
}
