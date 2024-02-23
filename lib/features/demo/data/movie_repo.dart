import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/infrastructure/exceptions/exception.dart';

import 'movie_api.dart';
import '../domain/demo_movie.dart';

part 'movie_repo.g.dart';

@riverpod
MovieRepo movieRepo(MovieRepoRef ref) {
  return MovieRepo(ref.watch(movieApiProvider));
}

class MovieRepo with RepositoryExceptionMixin {
  MovieRepo(this.api);

  final MovieApi api;

  Future<List<DemoMovie>> searchMovies(FilterMovieParams params) async {
    return runAsyncCatching(action: () async {
      final responses = await api.searchMovies(params);
      return responses.results;
    });
  }

  Future<List<DemoMovie>> trendingMovies(FilterMovieParams params) async {
    return runAsyncCatching(action: () async {
      final responses = await api.trendingMovies(params);
      return responses.results;
    });
  }
}
