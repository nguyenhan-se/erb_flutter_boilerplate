import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/presentation/utils/fp_framework.dart';

import '../domain/auth_credential.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Option<AuthCredential> build() => const None();

  void authenticateUser(AuthCredential credential) {
    state = Some(credential);
  }

  void unAuthenticateUser() {
    state = const None();
  }
}

@Riverpod(keepAlive: true)
bool isSigned(IsSignedRef ref) {
  return ref.watch(authStateProvider.select((auth) => auth.isSome()));
}
