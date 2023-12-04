import '../base/app_exception.dart';

class StorageException extends AppException {
  StorageException({
    required this.kind,
    required this.message,
    this.rootException,
  }) : super(AppExceptionType.storage);

  final StorageExceptionKind kind;
  final String message;
  final Object? rootException;
}

enum StorageExceptionKind {
  unknown,
  general,
  notFound, //Thrown when cache is empty or not found
}
