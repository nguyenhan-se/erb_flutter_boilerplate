import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/presentation/utils/fp_framework.dart';

import '../../../application/auth_state_provider.dart';
import '../../../data/auth_repo.dart';
import '../../../domain/auth_credential.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  FutureOr<Option<AuthCredential>> build() {
    return const None();
  }

  Future<void> signIn(SignInParams params) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final authRepo = ref.read(authRepoProvider);
      final credential = await authRepo.signIn(params);

      ref.read(authStateProvider.notifier).authenticateUser(credential);

      return Some(credential);
    });
  }
}
