import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

extension TabsGuardRouterExt on TabsRouter {
  Future<void> setActiveGuardIndex(
    int index, {
    bool notify = true,
    OnNavigationFailure? onFailure,
  }) async {
    final routeData = stackData[index];
    final can = await _canActive(routeData.route, onFailure: onFailure);
    if (can.continueNavigation) {
      setActiveIndex(index, notify: notify);
    }
  }

  Future<ResolverResult> _canActive(
    RouteMatch route, {
    OnNavigationFailure? onFailure,
    List<RouteMatch> pendingRoutes = const [],
    bool isReevaluating = false,
  }) async {
    AutoRouteGuard? rootGuard =
        (root is AutoRouteGuard) ? (root as AutoRouteGuard) : null;

    final guards = <AutoRouteGuard>[
      if (rootGuard != null) rootGuard,
      ...route.guards,
    ];
    if (guards.isEmpty) {
      return SynchronousFuture(
        const ResolverResult(
          continueNavigation: true,
          reevaluateNext: true,
        ),
      );
    }
    bool breakOnReevaluate = false;
    for (var guard in guards) {
      final completer = Completer<ResolverResult>();

      // NOTE: this will has no effect if there's a guard in progress
      // NO Re-builds  routes in stack and reevaluate guarded
      root.activeGuardObserver.add(guard);
      guard.onNavigation(
        NavigationResolver(
          root,
          completer,
          route,
          pendingRoutes: pendingRoutes,
          isReevaluating: isReevaluating,
        ),
        root,
      );
      final result = await completer.future;
      breakOnReevaluate |= result.reevaluateNext;
      if (!result.continueNavigation) {
        if (onFailure != null) {
          onFailure(RejectedByGuardFailure(route, guard));
        }

        root.activeGuardObserver.remove(guard);

        return ResolverResult(
          continueNavigation: false,
          reevaluateNext: breakOnReevaluate,
        );
      }
    }
    return ResolverResult(
      continueNavigation: true,
      reevaluateNext: breakOnReevaluate,
    );
  }
}
