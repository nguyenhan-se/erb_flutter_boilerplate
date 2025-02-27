import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/core/features/authentication/application/application.dart';

import '../app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthed = ref.read(authStateProvider).isSome();
    if (!isAuthed) {
      router.push(
        SignInRoute(
          onSignInResult: (_) {
            // ignore: deprecated_member_use
            router.pop();
            resolver.next();
          },
        ),
      );
    } else {
      resolver.next();
    }
  }
}
