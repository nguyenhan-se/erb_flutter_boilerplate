import 'package:erb_flutter_boilerplate/i18n/i18n.dart';
import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/app_env_service.dart';
import 'package:erb_flutter_boilerplate/core/features/authentication/application/auth_state_provider.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appEnv = ref.watch(appEnvServiceProvider);
    final t = ref.watch(translateProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App env:  ${appEnv.baseUrl}',
            ),
            Text(
              '${t.common.welcome}: ${ref.watch(authStateProvider).match(() => '', (credential) => '${credential.firstName} ${credential.lastName} ')}',
            ),
            ERbOutlineGradientButton(
              strokeWidth: 3,
              onTap: () => AutoRouter.of(context).push(const HomeDetailRoute()),
              label: 'Go Home Detail',
              // child: const Text('Toggle theme'),
            ),
            const ERbTextField(
              labelText: 'Hello world',
              helpText: 'asdasd',
              hasAsterisk: true,
            ),
          ],
        ),
      ),
    );
  }
}
