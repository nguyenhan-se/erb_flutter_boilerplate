import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

import '../domain/auth_credential.dart';
import 'remote/auth_api.dart';

part 'auth_repo.g.dart';

@riverpod
AuthRepo authRepo(AuthRepoRef ref) {
  return AuthRepo(
    api: ref.watch(authApiProvider),
  );
}

class AuthRepo with RepositoryExceptionMixin {
  AuthRepo({
    required this.api,
  });

  final AuthApi api;

  Future<AuthCredential> signIn(SignInParams params) {
    return runAsyncCatching(action: () async {
      final credential = await api.login(params);

      return credential;
    });
  }
}
