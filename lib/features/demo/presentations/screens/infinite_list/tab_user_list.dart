import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';

import 'demo_user_controller.dart';

class TabUserList extends HookConsumerWidget {
  const TabUserList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ERbPagedBuilder(
      // The [StateNotifierProvider] that holds the logic and the list of Posts
      provider: demoUserControllerProvider,
      // the first page we will ask
      firstPageKey: 0,
      pullToRefresh: true,
      // a function that build a single Post
      itemBuilder: (context, item, index) => ListTile(
        leading: CircleAvatar(
          child: CachedNetworkImageCircular(
            imageUrl: item.profilePicture,
            radius: 50,
          ),
        ),
        title: Text('${item.id} : ${item.name}'),
        onTap: () {},
      ),
      // The type of list we want to render
      // This can be any of the [infinite_scroll_pagination] widgets
      pagedBuilder: (controller, builder) => PagedListView(
        pagingController: controller,
        builderDelegate: builder,
      ),
    );
  }
}
