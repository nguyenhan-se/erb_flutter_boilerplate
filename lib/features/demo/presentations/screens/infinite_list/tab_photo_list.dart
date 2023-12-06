import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';

import 'demo_photo_controller.dart';

class TabPhotoList extends HookConsumerWidget {
  const TabPhotoList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ERbPagedBuilder(
      // The [StateNotifierProvider] that holds the logic and the list of Posts
      provider: demoPhotoControllerProvider,
      // the first page we will ask
      firstPageKey: 0,
      pullToRefresh: true,
      // a function that build a single Post
      itemBuilder: (context, item, index) => ListTile(
        leading: CircleAvatar(
          child: CachedNetworkImageCircular(
            imageUrl: item.thumbnailUrl,
            radius: 50,
          ),
        ),
        title: Text(item.title),
        onTap: () {},
      ),
      // The type of list we want to render
      // This can be any of the [infinite_scroll_pagination] widgets
      pagedBuilder: (controller, builder) => PagedGridView(
        pagingController: controller,
        builderDelegate: builder,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
      ),
    );
  }
}
