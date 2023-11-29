import 'strings.g.dart';

class LocaleHelper {
  static Future update(AppLocale locale) {
    return Future(() {
      // NOTE: no need to support useDeviceLocale
      // if (locale != null) {
      //   LocaleSettings.setLocale(locale);
      // } else {
      //   LocaleSettings.useDeviceLocale();
      // }
      LocaleSettings.setLocale(locale);
    });
  }
}
