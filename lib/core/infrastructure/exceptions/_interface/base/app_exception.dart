abstract class AppException implements Exception {
  const AppException(this.appExceptionType);

  final AppExceptionType appExceptionType;
}

// Define more type when need
enum AppExceptionType { remote, uncaught }
