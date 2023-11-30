import 'package:flutter/foundation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/core/features/authentication/application/application.dart';

import 'app_router.gr.dart';
import 'guards/auth_guard.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  final authGuard = AuthGuard(ref);

  return AppRouter(authGuard: authGuard);
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
  final AuthGuard authGuard;

  AppRouter({required this.authGuard});

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: SplashRoute.page, path: '/', initial: true),
        AutoRoute(page: SignInRoute.page, path: '/sign-in'),
        AutoRoute(page: SignUpRoute.page, path: '/sign-up'),
        AutoRoute(page: TalkerRoute.page, path: '/log-talker'),
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
                  guards: [authGuard],
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
                  initial: true,
                  page: SettingRoute.page,
                ),
                AutoRoute(
                  guards: [authGuard],
                  page: LanguageSettingRoute.page,
                  path: 'languages',
                  meta: const {'hideBottomNav': true},
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
