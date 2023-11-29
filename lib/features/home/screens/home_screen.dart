import 'package:erb_shared/extensions.dart';
import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/app_env_service.dart';
import 'package:erb_flutter_boilerplate/core/features/authentication/application/auth_state_provider.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appEnv = ref.watch(appEnvServiceProvider);
    final t = useI18n();

    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App env:  ${appEnv.baseUrl}',
            ),
            HookConsumer(builder: (context, ref, child) {
              final credential = ref.watch(authStateProvider
                  .select((item) => item.match(() => null, (value) => value)));
              if (credential.isNull) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  Text(
                    '${t.common.welcome}: ${credential!.firstName} ${credential.lastName}',
                  ),
                  CachedNetworkImageCircular(
                    imageUrl: ref
                        .watch(authStateProvider)
                        .match(() => null, (credential) => credential.image),
                    radius: 50,
                  ),
                ],
              );
            }),
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
