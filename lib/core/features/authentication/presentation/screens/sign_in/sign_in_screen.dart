import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

import '../../../domain/auth_credential.dart';
import 'sign_in_controller.dart';

@RoutePage()
class SignInScreen extends ConsumerWidget {
  final void Function(bool isLoggedIn)? onSignInResult;

  const SignInScreen({
    this.onSignInResult,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(signInProvider).isLoading;
    ref.listen(signInProvider, (previous, next) {
      next.whenOrNull(data: (credential) {
        credential.match(() {}, (_) {
          onSignInResult?.call(true);
        });
      });
    });

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Center(
            child: Text('sign in screen'),
          ),
          ERbElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    await ref.read(signInProvider.notifier).signIn(SignInParams(
                        username: 'kminchelle', password: '0lelplR'));
                  },
            label: 'Sign in',
            // child: const Text('Toggle theme'),
          ),
        ],
      ),
    );
  }
}