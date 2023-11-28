import 'strings.g.dart';

class LocaleHelper {
  static Future update(AppLocale? locale) {
    return Future(() {
      if (locale != null) {
        LocaleSettings.setLocale(locale);
      } else {
        LocaleSettings.useDeviceLocale();
      }
    });
  }
}
