import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'provider/user_controller.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ERbPagedBuilder(
      // The [StateNotifierProvider] that holds the logic and the list of Posts
      provider: userControllerProvider,
      // the first page we will ask
      firstPageKey: 1,
      pullToRefresh: true,
      // a function that build a single Post
      itemBuilder: (context, item, index) => ListTile(
        leading: CircleAvatar(child: Image.network(item.profilePicture)),
        title: Text(item.id),
      ),
      // The type of list we want to render
      // This can be any of the [infinite_scroll_pagination] widgets
      pagedBuilder: (controller, builder) =>
          PagedListView(pagingController: controller, builderDelegate: builder),
    );
  }
}
