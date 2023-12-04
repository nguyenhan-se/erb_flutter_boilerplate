import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/local/secure_storage_facade.dart';

import '../../domain/auth_pass.dart';

part 'auth_pass_storage.g.dart';

@riverpod
AuthPassStorage authPassStorage(AuthPassStorageRef ref) {
  return AuthPassStorage(
    secureStorageFacade: ref.watch(secureStorageFacadeProvider),
  );
}

class AuthPassStorage {
  AuthPassStorage({required this.secureStorageFacade});

  final SecureStorageFacade secureStorageFacade;

  static const String authDataKey = 'auth_pass';

  Future<void> cacheAuthPass(AuthPass authPass) async {
    final jsonString = json.encode(authPass.toJson());
    await secureStorageFacade.write(authDataKey, jsonString);
  }

  Future<AuthPass> getAuthPass() async {
    final jsonString = await secureStorageFacade.read(authDataKey);
    if (jsonString != null) {
      final authCredential =
          AuthPass.fromJson(json.decode(jsonString) as Map<String, dynamic>);
      return authCredential;
    } else {
      throw StorageException(
        kind: StorageExceptionKind.notFound,
        message: 'Cache Not Found',
      );
    }
  }

  Future<void> clearAuthPass() async {
    await secureStorageFacade.delete(authDataKey);
  }
}
