import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

import 'tab_photo_list.dart';
import 'tab_user_list.dart';
import 'tab_user_list_filter.dart';

@RoutePage()
class DemoInfiniteListScreen extends HookConsumerWidget {
  const DemoInfiniteListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexedStack = useState<int>(0);

    return Scaffold(
      appBar: AppBar(),
      body: CrossFadeIndexedStack(
        index: indexedStack.value,
        duration: const Duration(milliseconds: 500),
        lazy: true,
        children: const [TabPhotoList(), TabUserList(), TabUserListFilter()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexedStack.value,
        onTap: (index) => indexedStack.value = index,
        items: const [
          BottomNavigationBarItem(
              label: 'Demo Photo', icon: Icon(Icons.photo_album)),
          BottomNavigationBarItem(
            label: 'Demo simple',
            icon: Icon(Icons.account_circle),
          ),
          BottomNavigationBarItem(
            label: 'Demo filter',
            icon: Icon(Icons.filter_1),
          ),
        ],
      ),
    );
  }
}
