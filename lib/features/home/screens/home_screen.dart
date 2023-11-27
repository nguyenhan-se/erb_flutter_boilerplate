import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/app_env_service.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appEnv = ref.watch(appEnvServiceProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App env:  ${appEnv.baseUrl}',
            ),
            ERbOutlineGradientButton(
              strokeWidth: 3,
              onTap: () => AutoRouter.of(context).push(const HomeDetailRoute()),
              label: 'Go Home Detail',
              // child: const Text('Toggle theme'),
            ),
            ERbElevatedButton(
              onPressed: () => AutoRouter.of(context).push(const SignInRoute()),
              label: 'Go Signin screen',
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
