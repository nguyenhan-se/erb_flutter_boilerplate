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
  static const designWidth = 375.0;
  static const designHeight = 812.0;
}
