import 'package:dart_mappable/dart_mappable.dart';

part 'paginated.mapper.dart';

@MappableClass()
class PaginatedResponse<T> with PaginatedResponseMappable<T> {
  final List<T> results;

  final int page;
  @MappableField(key: 'total_pages')
  final int totalPages;

  PaginatedResponse({
    required this.results,
    this.page = 1,
    this.totalPages = 0,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) =>
      PaginatedResponseMapper.fromJson<T>(json);
}

@MappableClass()
class PaginatedQuery with PaginatedQueryMappable {
  final int page;

  PaginatedQuery({
    required this.page,
  });

  factory PaginatedQuery.fromJson(Map<String, dynamic> json) =>
      PaginatedQueryMapper.fromJson(json);
}
