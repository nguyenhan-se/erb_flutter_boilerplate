import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

class AutoTabsGuardRouter {
  late TabsRouter tabsRouter;

  late StackRouter _stackRouter;

  AutoTabsGuardRouter._({
    required this.tabsRouter,
    required StackRouter stackRouter,
  }) {
    _stackRouter = stackRouter;
  }

  factory AutoTabsGuardRouter.of(BuildContext context, {bool watch = false}) {
    final scope = TabsRouterScope.of(context, watch: watch);
    final stackRouter = AutoRouter.of(context);

    assert(() {
      if (scope == null) {
        throw FlutterError(
            'AutoTabsRouter operation requested with a context that does not include an AutoTabsRouter.\n'
            'The context used to retrieve the AutoTabsRouter must be that of a widget that '
            'is a descendant of an AutoTabsRouter widget.');
      }
      return true;
    }());

    return AutoTabsGuardRouter._(
      tabsRouter: scope!.controller,
      stackRouter: stackRouter,
    );
  }

  /// The index of active page
  int get activeIndex => tabsRouter.activeIndex;

  /// The index of previous active page
  int? get previousIndex => tabsRouter.previousIndex;

  Future<void> setActiveIndex(
    int index, {
    bool notify = true,
    OnNavigationFailure? onFailure,
  }) async {
    _stackRouter.root.routeData.route.guards;
    final a = tabsRouter.stackData[index];
    final can = await _canActive(a.route, onFailure: onFailure);
    if (can.continueNavigation) {
      tabsRouter.setActiveIndex(index, notify: notify);
    }
  }

  Future<ResolverResult> _canActive(
    RouteMatch route, {
    OnNavigationFailure? onFailure,
    List<RouteMatch> pendingRoutes = const [],
    bool isReevaluating = false,
  }) async {
    final guards = <AutoRouteGuard>[
      ...route.guards,
      ..._stackRouter.root.routeData.route.guards,
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

      guard.onNavigation(
        NavigationResolver(
          _stackRouter,
          completer,
          route,
          pendingRoutes: pendingRoutes,
          isReevaluating: isReevaluating,
        ),
        _stackRouter,
      );
      final result = await completer.future;
      breakOnReevaluate |= result.reevaluateNext;
      if (!result.continueNavigation) {
        if (onFailure != null) {
          onFailure(RejectedByGuardFailure(route, guard));
        }

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
