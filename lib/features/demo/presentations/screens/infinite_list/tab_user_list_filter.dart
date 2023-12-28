import 'package:erb_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app_constants/app_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:erb_flutter_boilerplate/core/widgets/widgets.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';

import 'demo_user_filter_controller.dart';

class TabUserListFilter extends HookConsumerWidget {
  const TabUserListFilter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debounce = useDebounce(const Duration(milliseconds: 500));

    useEffect(
      () {
        ref
            .read(demoUserFilterControllerProvider.notifier)
            .updateFilter('join');

        return;
      },
    );
    return Column(
      children: [
        Padding(
          padding: KEdgeInsets.a8.size,
          child: ERbTextField(
            hintText: 'Search',
            onChanged: (text) {
              debounce(() {
                ref
                    .read(demoUserFilterControllerProvider.notifier)
                    .updateFilter(text.trim().isEmpty ? 'join' : text);

                ref.invalidate(demoUserFilterControllerProvider);
              });
            },
          ),
        ),
        Expanded(
          child: ERbPagedBuilder(
            // The [StateNotifierProvider] that holds the logic and the list of Posts
            provider: demoUserFilterControllerProvider,
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
          ),
        )
      ],
    );
  }
}
