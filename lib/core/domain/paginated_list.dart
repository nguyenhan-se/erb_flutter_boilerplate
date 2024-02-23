import 'package:dart_mappable/dart_mappable.dart';

part 'paginated_list.mapper.dart';

@MappableClass()
class PaginatedList<T> with PaginatedListMappable<T> {
  final List<T> results;

  final int page;
  @MappableField(key: 'total_pages')
  final int totalPages;

  PaginatedList({
    required this.results,
    this.page = 1,
    this.totalPages = 0,
  });

  factory PaginatedList.fromJson(Map<String, dynamic> json) =>
      PaginatedListMapper.fromJson<T>(json);
}
