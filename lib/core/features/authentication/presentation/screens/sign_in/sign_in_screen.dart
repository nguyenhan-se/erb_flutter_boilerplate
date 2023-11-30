import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:app_constants/app_constants.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';

import '../../../domain/auth_credential.dart';
import 'sign_in_controller.dart';

@RoutePage()
class SignInScreen extends HookConsumerWidget {
  final void Function(bool isLoggedIn)? onSignInResult;

  const SignInScreen({
    this.onSignInResult,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEasyAsyncListen(signInProvider);

    ref.listen(signInProvider, (previous, next) {
      next.whenOrNull(data: (credential) {
        credential.match(() {}, (_) {
          onSignInResult?.call(true);
        });
      });
    });

    return AppScaffold(
      appBar: AppBar(),
      body: ERbFormLayout.simple(
        content: const Center(
          child: Text('sign in screen'),
        ),
        bottom: Padding(
          padding: KEdgeInsets.v16.size,
          child: AsyncButton(
            onPressed: () => ref.read(signInProvider.notifier).signIn(
                SignInParams(username: 'kminchelle', password: '0lelplR')),
            label: 'Sign in',
          ),
        ),
      ),
    );
  }
}
