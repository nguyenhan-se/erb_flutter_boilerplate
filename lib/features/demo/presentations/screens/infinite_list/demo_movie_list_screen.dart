import 'package:erb_ui/erb_ui.dart';
import 'package:flutter/material.dart';
import 'package:app_constants/app_constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';
import 'package:erb_flutter_boilerplate/core/presentation/hook/hook.dart';

import 'widgets/movie_item.dart';
import 'demo_movie_controller.dart';
import 'widgets/movie_grid_item.dart';
import '../../../domain/demo_movie.dart';

@RoutePage()
class DemoInfiniteListScreen extends HookConsumerWidget {
  const DemoInfiniteListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debounce = useDebounce(const Duration(milliseconds: 500));
    final gridViewEnabled = useState(false);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: KEdgeInsets.h16.size,
        child: Column(
          children: [
            ERbTextField(
              hintText: 'Search',
              onChanged: (text) {
                debounce(() {
                  ref
                      .read(demoMovieControllerProvider.notifier)
                      .updateFilter(FilterMovieParams(query: text));
                });
              },
            ),
            KSizedBox.h16.size,
            Expanded(
              child: gridViewEnabled.value
                  ? ERbPagedGridView(
                      provider: demoMovieControllerProvider,
                      firstPageKey: 1,
                      pullToRefresh: true,
                      skeleton: Padding(
                        padding: KEdgeInsets.ob16.size,
                        child: MovieGridItem(movie: DemoMovie.mockDummy()),
                      ),
                      itemBuilder: (context, item, _) =>
                          MovieGridItem(movie: item),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1.22,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    )
                  : ERbPagedListView(
                      provider: demoMovieControllerProvider,
                      firstPageKey: 1,
                      pullToRefresh: true,
                      skeleton: Padding(
                        padding: KEdgeInsets.ob16.size,
                        child: MovieItem(movie: DemoMovie.mockDummy()),
                      ),
                      itemBuilder: (context, item, _) => Padding(
                        padding: KEdgeInsets.ob16.size,
                        child: MovieItem(movie: item),
                      ),
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gridViewEnabled.value = !gridViewEnabled.value;
          return ref.refresh(demoMovieControllerProvider);
        },
        child: Icon(gridViewEnabled.value ? Icons.view_list : Icons.grid_view),
      ),
    );
  }
}
