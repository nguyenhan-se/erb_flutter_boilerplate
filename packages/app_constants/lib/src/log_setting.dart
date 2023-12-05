import 'package:flutter/foundation.dart';

class LogSettings {
  const LogSettings._();

  /// log dio interceptor
  static const enableDioResponseData = kDebugMode;
  static const enableDioResponseHeaders = false;
  static const enableDioResponseMessage = kDebugMode;
  static const enableDioRequestData = kDebugMode;
  static const enableDioRequestHeaders = false;

  /// log riverpod
  static const defaultEnableRiverpodLog = kDebugMode;
  static const enableRiverpodDidAddProvider = kDebugMode;
  static const enableRiverpodDidDisposeProvider = false;
  static const enableRiverpodDidUpdateProvider = kDebugMode;
  static const enableRiverpodDidFail = kDebugMode;

  /// log auto_route
  static const defaultEnableAutoRouteLog = kDebugMode;
  static const enablePrintDidPush = kDebugMode;
  static const enablePrintDidPop = kDebugMode;
  static const enablePrintDidReplace = kDebugMode;
  static const enablePrintDidRemove = false;
  static const enablePrintDidInitTabRoute = false;
  static const enablePrintDidChangeTabRoute = kDebugMode;
}
