import 'package:erb_shared/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';

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
          final params = filter?.copyWith(page: page);
          if (params.isNotNull && params!.query!.isNotEmpty) {
            final data = await repo.searchMovies(params.copyWith(page: page));
            return data;
          }
          final data = await repo.trendingMovies(
              (filter ?? FilterMovieParams.init()).copyWith(page: page));
          return data;
        },
      ),
    );
  }
}
