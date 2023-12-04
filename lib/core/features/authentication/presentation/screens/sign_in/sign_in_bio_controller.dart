import 'package:erb_flutter_boilerplate/core/presentation/utils/fp_framework.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';

import '../../../data/auth_pass_repo.dart';
import '../../../domain/auth_credential.dart';
import 'sign_in_controller.dart';

part 'sign_in_bio_controller.g.dart';

@riverpod
class SignInBio extends _$SignInBio {
  @override
  FutureOr<Option<Unit>> build() {
    ref.cacheFor(const Duration(minutes: 5));

    return const None();
  }

  Future<void> signInBio() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final authPassRepo = ref.read(authPassRepoProvider);
      final authPass = await authPassRepo.getCacheAuthPass();
      await ref.read(signInProvider.notifier).signIn(SignInParams(
          username: authPass.username, password: authPass.password));

      return const Some(unit);
    });
  }
}
