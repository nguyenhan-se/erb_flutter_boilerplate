import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';

import 'package:erb_flutter_boilerplate/core/domain/domain.dart';

import '../../../data/movie_repo.dart';
import '../../../domain/demo_movie.dart';

part 'demo_movie_controller.g.dart';

@riverpod
class DemoMovieController extends _$DemoMovieController
    with PagedMixinFilter<DemoMovie, FilterMovieParams> {
  @override
  PagedState<DemoMovie> build() {
    final repo = ref.watch(movieRepoProvider);

    return init(
      fetcher: PagedFetcher(
        load: (page, limit) async {
          await Future.delayed(const Duration(seconds: 2));
          if (filter?.query?.isNotEmpty ?? false) {
            final data =
                await repo.searchMovies(PaginatedQuery(page: page), filter!);
            return data;
          }
          final data = await repo.trendingMovies(PaginatedQuery(page: page));
          return data;
        },
      ),
    );
  }
}
