import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

part 'secure_storage_facade.g.dart';

@Riverpod(keepAlive: true)
SecureStorageFacade secureStorageFacade(SecureStorageFacadeRef ref) {
  return SecureStorageFacade(
    secureStorage: const FlutterSecureStorage(),
  );
}

class SecureStorageFacade {
  SecureStorageFacade({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  Future<void> write(String key, String value) async {
    return _futureErrorHandler(() async {
      return secureStorage.write(key: key, value: value);
    });
  }

  Future<String?> read(String key) async {
    return _futureErrorHandler(() async {
      return secureStorage.read(key: key);
    });
  }

  Future<void> delete(String key) async {
    return _futureErrorHandler(() async {
      return secureStorage.delete(key: key);
    });
  }

  Future<void> deleteAll() async {
    return _futureErrorHandler(() async {
      return secureStorage.deleteAll();
    });
  }

  Future<T> _futureErrorHandler<T>(Future<T> Function() body) async {
    try {
      return await body.call();
    } catch (e, st) {
      final error = e.errorToStorageException();
      throw Error.throwWithStackTrace(error, st);
    }
  }
}

extension StorageErrorExtension on Object {
  StorageException errorToStorageException() {
    final exception = this;

    if (exception is StorageException) {
      return exception;
    }

    return StorageException(
      kind: StorageExceptionKind.general,
      message: exception.toString(),
      rootException: exception,
    );
  }
}
