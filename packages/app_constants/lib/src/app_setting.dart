import 'package:flutter/services.dart';

class AppSettings {
  AppSettings._();

  static const appTitle = 'ERb boilerplate';

  static const hideKeyboardWhenTouchOutside = true;
  static const safeArea = true;
  static const resizeToAvoidBottomInset = false;
  static const systemUiOverlay = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
  );

  // app design size
  static const double wdp = 428.0;
  static const double hdp = 926.0;

  static const double maxMobileWidth = 450;
  static const double maxTabletWidth = 800;
  static const double maxDesktopWidth = 1920;
}
