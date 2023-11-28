import 'package:flutter/foundation.dart';

class LogSettings {
  const LogSettings._();

  /// log dio interceptor
  static const enableDioResponseData = kDebugMode;
  static const enableDioResponseHeaders = false;
  static const enableDioResponseMessage = kDebugMode;
  static const enableDioRequestData = kDebugMode;
  static const enableDioRequestHeaders = false;
}
