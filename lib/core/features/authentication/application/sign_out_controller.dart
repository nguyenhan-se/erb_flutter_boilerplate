import 'dart:async';

import 'package:erb_shared/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/presentation/utils/fp_framework.dart';

import '../data/auth_repo.dart';
import 'auth_state_provider.dart';

part 'sign_out_controller.g.dart';

@riverpod
class SignOutController extends _$SignOutController {
  @override
  FutureOr<Option<Unit>> build() => const None();

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      unawaited(ref.read(authRepoProvider).signOut().suppressError());

      ref.read(authStateProvider.notifier).unAuthenticateUser();

      return const Some(unit);
    });
  }
}
