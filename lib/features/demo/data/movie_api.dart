import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:erb_flutter_boilerplate/core/domain/domain.dart';
import 'package:erb_flutter_boilerplate/core/infrastructure/network/dio/dio_collection.dart';

import '../domain/demo_movie.dart';

part 'movie_api.g.dart';

@riverpod
MovieApi movieApi(MovieApiRef ref) {
  return MovieApi(ref.watch(dioProvider).movie);
}

@RestApi()
abstract class MovieApi {
  factory MovieApi(Dio dio) = _MovieApi;

  @GET('/search/movie')
  Future<PaginatedResponse<DemoMovie>> searchMovies(
    @Queries() PaginatedQuery page,
    @Queries() FilterMovieParams queries,
  );

  @GET('/trending/movie/day')
  Future<PaginatedResponse<DemoMovie>> trendingMovies(
    @Queries() PaginatedQuery page,
  );
}
