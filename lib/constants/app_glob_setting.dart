import 'package:env/env.dart';

class AppGlobalSetting {
  const AppGlobalSetting._();

  static final baseUrl = EnvFlavor().baseUrl;

  static final tmdbUrl = EnvFlavor().tmdbUrl;

  static final tmdbImg = EnvFlavor().tmdbImg;
}
