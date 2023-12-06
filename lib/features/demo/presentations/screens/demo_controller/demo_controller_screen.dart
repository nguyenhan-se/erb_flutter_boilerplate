import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

enum TabMenu {
  infiniteList(Icons.home),
  widgets(Icons.apps_sharp);

  const TabMenu(this.icon);

  final IconData icon;

  String get label {
    switch (this) {
      case TabMenu.infiniteList:
        return 'infinite-list';
      case TabMenu.widgets:
        return 'widgets';
    }
  }
}

@RoutePage()
class DemoControllerScreen extends HookConsumerWidget {
  const DemoControllerScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        DemoInfiniteListRoute(),
        DemoCompRoute(),
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

    return NavigationBar(
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
    );
  }
}
