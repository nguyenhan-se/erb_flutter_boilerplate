import 'package:auto_route/auto_route.dart';

/// Guards against duplicate navigation to this route
class DuplicateGuard extends AutoRouteGuard {
  DuplicateGuard();
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Duplicate navigation
    if (resolver.route.name == router.current.name) {
      resolver.next(false);
    } else {
      resolver.next(true);
    }
  }
}
