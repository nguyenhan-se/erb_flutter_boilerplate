import 'package:assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:erb_flutter_boilerplate/routes/routes.dart';

import 'providers/splash_provider.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';

@RoutePage()
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWarmedUp = !ref.watch(splashServicesWarmupProvider).isLoading;
    if (isWarmedUp) {
      ref.listen<AsyncValue<PageRouteInfo>>(
        splashTargetProvider,
        (prevState, newState) {
          late PageRouteInfo nextRoute;
          newState.whenOrNull(
            data: (next) => nextRoute = next,
            error: (e, st) => nextRoute = const NoInternetRoute(),
          );
          AutoRouter.of(context).replace(nextRoute);
        },
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssets.images.logo.image(width: 100, height: 100),
            HookConsumer(builder: (context, ref, child) {
              final t = useI18n();

              return Text(t.common.loading);
            }),
          ],
        ),
      ),
    );
  }
}
