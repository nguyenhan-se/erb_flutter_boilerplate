import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/core/features/authentication/application/auth_state_provider.dart';

import 'app_router.gr.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(ref);
});

final appRouterReevaluateListenableProvider =
    Provider<ValueNotifier<bool?>>((ref) {
  final listenable = ValueNotifier<bool?>(null);

  ref.listen(
    authStateProvider.select((user) => user.isSome()),
    (_, isAuthenticated) => listenable.value = isAuthenticated,
  );

  ref.onDispose(() {
    listenable.dispose();
  });

  return listenable;
});

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final Ref ref;

  AppRouter(this.ref);

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: SplashRoute.page, path: '/', initial: true),
        AutoRoute(page: SignInRoute.page, path: '/sign'),
        CustomRoute(
          page: TabControllerRoute.page,
          path: '/app',
          children: [
            AutoRoute(
              path: 'home',
              page: HomeStackRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: HomeRoute.page,
                ),
                AutoRoute(
                  page: HomeDetailRoute.page,
                  path: 'detail',
                  meta: const {'hideBottomNav': true},
                ),
              ],
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsStackRoute.page,
              children: <AutoRoute>[
                AutoRoute(
                  page: SettingRoute.page,
                ),
              ],
            ),
          ],
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        AutoRoute(page: NotFoundRoute.page, path: '*'),
      ];
}

@RoutePage()
class HomeStackScreen extends AutoRouter {
  const HomeStackScreen({super.key});
}

@RoutePage()
class SettingsStackScreen extends AutoRouter {
  const SettingsStackScreen({super.key});
}
