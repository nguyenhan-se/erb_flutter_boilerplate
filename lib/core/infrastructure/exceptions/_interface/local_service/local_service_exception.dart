import '../base/app_exception.dart';

class LocalServiceException extends AppException {
  LocalServiceException({
    required this.kind,
    required this.message,
  }) : super(AppExceptionType.localService);

  final LocalServiceExceptionKind kind;
  final String message;
}

enum LocalServiceExceptionKind {
  unknown,
  biometric,
}
