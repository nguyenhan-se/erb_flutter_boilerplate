import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_router.gr.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(ref);
});

final appRouterReevaluateListenableProvider =
    Provider<ValueNotifier<bool?>>((ref) {
  final listenable = ValueNotifier<bool?>(null);

  // ref.listen(
  //   authStateProvider.select((user) => user.isSome()),
  //   (_, isAuthenticated) => listenable.value = isAuthenticated,
  // );

  ref.onDispose(() {
    listenable.dispose();
  });

  // return AppRouter(ref);
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
        CustomRoute(
          page: TabControllerRoute.page,
          path: '/tabs',
          children: [
            AutoRoute(
              path: 'home',
              page: HomeTabRoute.page,
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
            AutoRoute(page: SettingRoute.page, path: 'settings'),
          ],
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        AutoRoute(page: NotFoundRoute.page, path: '*'),
      ];
}

@RoutePage()
class HomeTabScreen extends AutoRouter {
  const HomeTabScreen({super.key});
}