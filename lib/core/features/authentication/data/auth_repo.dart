import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

import '../domain/auth_credential.dart';
import 'remote/auth_api.dart';

part 'auth_repo.g.dart';

@riverpod
AuthRepo authRepo(AuthRepoRef ref) {
  final box = Hive.box<AuthCredential>(AuthRepo.key);

  return AuthRepo(
    api: ref.watch(authApiProvider),
    box: box,
  );
}

class AuthRepo with RepositoryExceptionMixin {
  AuthRepo({
    required this.api,
    required this.box,
  });

  static const String key = 'authentication';

  final AuthApi api;
  final Box<AuthCredential> box;

  Future<AuthCredential> signIn(SignInParams params) {
    return runAsyncCatching(action: () async {
      final credential = await api.login(params);

      cachedAuthCredential(credential);

      return credential;
    });
  }

  Future<void> signOut() async {
    await clear();
  }

  // box
  AuthCredential? get currentUser => box.get(key);

  Future<void> cachedAuthCredential(AuthCredential credential) {
    return box.put(key, credential);
  }

  Future<void> clear() => box.clear();

  static Future<void> prepare() async {
    await Hive.openBox<AuthCredential>(key);
  }
}
