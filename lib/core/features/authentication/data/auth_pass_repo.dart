import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

import '../domain/auth_pass.dart';
import 'local/auth_pass_storage.dart';

part 'auth_pass_repo.g.dart';

@riverpod
AuthPassRepo authPassRepo(AuthPassRepoRef ref) {
  return AuthPassRepo(
    authPassStorage: ref.watch(authPassStorageProvider),
  );
}

class AuthPassRepo with RepositoryExceptionMixin {
  final AuthPassStorage authPassStorage;

  AuthPassRepo({
    required this.authPassStorage,
  });

  Future<void> cacheAuthPass(AuthPass params) async {
    return runAsyncCatching(action: () async {
      return authPassStorage.cacheAuthPass(params);
    });
  }

  Future<AuthPass> getCacheAuthPass() async {
    return runAsyncCatching(action: () async {
      return authPassStorage.getAuthPass();
    });
  }

  Future<void> clearAuthPass() async {
    return runAsyncCatching(action: () async {
      return authPassStorage.clearAuthPass();
    });
  }
}
