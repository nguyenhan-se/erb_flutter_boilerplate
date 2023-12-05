import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerRouterObserverSettings {
  const TalkerRouterObserverSettings({
    this.enabled = true,
    this.printDidPush = true,
    this.printDidPop = true,
    this.printDidReplace = false,
    this.printDidRemove = false,
    this.printDidInitTabRoute = false,
    this.printDidChangeTabRoute = false,
  });

  final bool enabled;
  final bool printDidPush;
  final bool printDidPop;
  final bool printDidReplace;
  final bool printDidRemove;
  final bool printDidInitTabRoute;
  final bool printDidChangeTabRoute;
}

/// This class observers all events happening in routing/navigation
class RouterObserver extends AutoRouterObserver {
  RouterObserver({
    Talker? talker,
    this.settings = const TalkerRouterObserverSettings(),
  }) {
    _talker = talker ?? Talker();
  }
  late Talker _talker;
  final TalkerRouterObserverSettings settings;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (!settings.enabled || !settings.printDidPush) {
      return;
    }

    _talker.logTyped(TalkerRouteLog(
        mess:
            'New route pushed: [${route.data?.path}] ${route.settings.name} Previous route is: ${previousRoute?.settings.name}'));
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (!settings.enabled || !settings.printDidPop) {
      return;
    }

    _talker.logTyped(TalkerRouteLog(
        mess:
            'Previous route poped: [${route.data?.path}] ${route.settings.name} Active route is: ${previousRoute?.settings.name}'));
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (!settings.enabled || !settings.printDidReplace) {
      return;
    }

    _talker.logTyped(TalkerRouteLog(
        mess:
            'Route [${newRoute?.data?.path}] ${newRoute?.settings.name} is replaced with ${oldRoute?.settings.name}'));
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (!settings.enabled || !settings.printDidRemove) {
      return;
    }

    _talker.logTyped(TalkerRouteLog(
        mess:
            'Route [${route.data?.path}] ${route.settings.name} is removed. Previous route is:  ${previousRoute?.settings.name}'));
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    if (!settings.enabled || !settings.printDidInitTabRoute) {
      return;
    }

    _talker.logTyped(TalkerRouteLog(
        mess:
            'Tab route visited: [${route.path}] ${route.name} Previous route is: ${previousRoute?.name}'));
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    if (!settings.enabled || !settings.printDidChangeTabRoute) {
      return;
    }

    _talker.logTyped(TalkerRouteLog(
        mess:
            'Tab route re-visited: [${route.path}] ${route.name} Previous route is: ${previousRoute.name}'));
  }
}

class TalkerRouteLog extends TalkerLog {
  TalkerRouteLog({
    required String mess,
  }) : super(_createMessage(mess));

  @override
  AnsiPen get pen => AnsiPen()..xterm(135);

  @override
  String get title => WellKnownTitles.route.title;

  static String _createMessage(
    String mess,
  ) {
    final buffer = StringBuffer();
    buffer.write('\n$mess');
    return buffer.toString();
  }
}
