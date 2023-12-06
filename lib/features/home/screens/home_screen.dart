import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:erb_shared/extensions.dart';
import 'package:app_constants/app_constants.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';
import 'package:erb_flutter_boilerplate/core/presentation/utils/riverpod_framework.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/services/app_env_service.dart';
import 'package:erb_flutter_boilerplate/core/features/authentication/application/application.dart';

import 'user_list.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAdaptiveSize();
    final t = useI18n();
    final appEnv = ref.watch(appEnvServiceProvider);

    return AppScaffold(
      body: Column(
        children: [
          Expanded(
            child: ERbFillViewportScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: KEdgeInsets.a16.size.flex,
                      child: Text('App env:  ${appEnv.baseUrl}'),
                    ),
                    HookConsumer(builder: (context, ref, child) {
                      final credential = ref.watch(authStateProvider.select(
                          (item) => item.match(() => null, (value) => value)));
                      if (credential.isNull) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        children: [
                          Text(
                            '${t.common.welcome}: ${credential!.firstName} ${credential.lastName}',
                          ),
                          CachedNetworkImageCircular(
                            imageUrl: ref.watch(authStateProvider).match(
                                () => null, (credential) => credential.image),
                            radius: 50,
                          ),
                        ],
                      );
                    }),
                    ERbOutlineGradientButton(
                      strokeWidth: 3,
                      onTap: () =>
                          AutoRouter.of(context).push(const HomeDetailRoute()),
                      label: 'Go Home Detail',
                      // child: const Text('Toggle theme'),
                    ),
                    KSizedBox.h24.size.flex,
                    const ERbTextField(
                      labelText: 'Hello world',
                      helpText: 'asdasd',
                      hasAsterisk: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: TodoList(),
          )
        ],
      ),
    );
  }
}
