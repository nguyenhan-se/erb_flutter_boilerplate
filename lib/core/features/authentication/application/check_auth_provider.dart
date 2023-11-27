import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_repo.dart';
import '../domain/auth_credential.dart';
import 'auth_state_provider.dart';

part 'check_auth_provider.g.dart';

@riverpod
Future<AuthCredential?> checkAuth(CheckAuthRef ref) async {
  final sub = ref.listen(authStateProvider.notifier, (prev, next) {});
  ref.listenSelf((previous, next) {

    next.whenOrNull(
      data: (credential) {
        if (credential != null) sub.read().authenticateUser(credential);
      },
    );
  });

  return ref.watch(authRepoProvider).currentUser;
}
