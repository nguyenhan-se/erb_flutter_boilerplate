import 'package:dart_mappable/dart_mappable.dart';

part 'demo_movie.mapper.dart';

@MappableClass()
class DemoMovie with DemoMovieMappable {
  final bool? adult;
  @MappableField(key: 'backdrop_path')
  final String? backdropPath;
  int? id;
  @MappableField(key: 'original_language')
  String? originalLanguage;
  @MappableField(key: 'original_title')
  String? originalTitle;
  String? overview;
  double? popularity;
  @MappableField(key: 'poster_path')
  String? posterPath;
  @MappableField(key: 'release_date')
  String? releaseDate;
  String? title;
  bool? video;
  @MappableField(key: 'vote_average')
  double? voteAverage;
  @MappableField(key: 'vote_count')
  int? voteCount;

  DemoMovie({
    this.adult,
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory DemoMovie.mockDummy() => DemoMovie(
        title: 'Dummy',
        overview: 'Dummy',
        voteCount: 0,
        voteAverage: 0,
        originalTitle: 'Dummy',
      );

  static const fromJson = DemoMovieMapper.fromJson;
}

@MappableClass()
class FilterMovieParams with FilterMovieParamsMappable {
  final String? query;
  final int? page;

  FilterMovieParams({
    this.query,
    this.page,
  });

  factory FilterMovieParams.init() {
    return FilterMovieParams(
      query: '',
    );
  }

  static const fromJson = FilterMovieParamsMapper.fromJson;
}
