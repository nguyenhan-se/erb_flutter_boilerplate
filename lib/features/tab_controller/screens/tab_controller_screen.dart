import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

enum TabMenu {
  home(Icons.home),
  settings(Icons.settings);

  const TabMenu(this.icon);

  final IconData icon;

  String get label {
    switch (this) {
      case TabMenu.home:
        return 'home';
      case TabMenu.settings:
        return 'setting';
    }
  }
}

@RoutePage()
class TabControllerScreen extends HookConsumerWidget {
  const TabControllerScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        SettingRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        // the passed child is technically our animated selected-tab page
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return PopScope(
          canPop: tabsRouter.activeIndex == 0,
          onPopInvoked: (didPop) {
            tabsRouter.setActiveIndex(0);
          },
          child: Scaffold(
            body: child,
            bottomNavigationBar: const _BottomNavBar(),
          ),
        );
      },
    );
  }
}

class _BottomNavBar extends HookConsumerWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabsRouter = AutoTabsRouter.of(context);
    final selectedIndex =
        useListenableSelector(tabsRouter, () => tabsRouter.activeIndex);

    final hideBottomNav =
        context.topRouteMatch.meta.containsKey('hideBottomNav') &&
            context.topRouteMatch.meta['hideBottomNav'] == true;

    return Offstage(
      offstage: hideBottomNav,
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          tabsRouter.setActiveIndex(index);
        },
        destinations: TabMenu.values.map((item) {
          return NavigationDestination(
            icon: Icon(item.icon),
            label: item.label,
            selectedIcon: Icon(
              item.icon,
              color: Theme.of(context).primaryColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
