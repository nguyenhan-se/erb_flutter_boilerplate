import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:app_constants/app_constants.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/fp_framework.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/local_auth_service.dart';
import 'package:erb_flutter_boilerplate/core/features/authentication/application/application.dart';

import '../../../domain/auth_credential.dart';
import 'sign_in_controller.dart';
import 'sign_in_bio_controller.dart';

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AsyncButton(
                onPressed: () async {
                  final signInParams =
                      SignInParams(username: 'kminchelle', password: '0lelplR');

                  await ref
                      .read(signInProvider.notifier)
                      .signIn(signInParams)
                      .then((_) => ref
                          .read(signInEventProvider.notifier)
                          .update((_) => Some(signInParams)));
                },
                label: 'Sign in',
              ),
              KSizedBox.w12.size,
              HookConsumer(
                builder: (context, ref, child) {
                  final authBiometricSettingAsync =
                      ref.watch(authBiometricServiceProvider);

                  final isBiometricEnabled = useMemoized(() {
                    final authSetting = authBiometricSettingAsync.valueOrNull;
                    if (authSetting?.isBiometricSupported != true) {
                      return false;
                    }

                    return authSetting!.isBiometricEnabled;
                  }, [authBiometricSettingAsync]);
                  return AsyncButton(
                    enabled: isBiometricEnabled,
                    onPressed: () async {
                      final isAuth =
                          await LocalAuthenticationService.authenticate();
                      if (isAuth) {
                        await ref.read(signInBioProvider.notifier).signInBio();
                      }
                    },
                    label: 'Sign in bio',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
