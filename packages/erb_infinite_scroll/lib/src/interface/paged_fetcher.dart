typedef LoadFunction<PageKeyType, ItemType> = Future<List<ItemType>?> Function(
    PageKeyType page, int limit);

typedef NextPageKeyBuilder<PageKeyType, ItemType> = PageKeyType? Function(
    List<ItemType>? lastItems, PageKeyType page, int limit);

class NextPageKeyBuilderDefault<ItemType> {
  static NextPageKeyBuilder<int, dynamic> mysqlPagination =
      (List<dynamic>? lastItems, int page, int limit) {
    return (lastItems == null || lastItems.length < limit) ? null : (page + 1);
  };
}

///Abstract class for defining the the Notifier interface.
///Each provider should implement this class
abstract interface class PagedNotifier<PageKeyType, ItemType> {
  Future<List<ItemType>?> load(PageKeyType page, int limit);
}

class PagedFetcher<PageKeyType, ItemType> {
  /// Load function
  final LoadFunction<PageKeyType, ItemType> load;
  final NextPageKeyBuilder<PageKeyType, ItemType> nextPageKeyBuilder;

  /// A builder for providing a custom error string
  final dynamic Function(dynamic error)? errorBuilder;

  PagedFetcher({
    required this.load,
    required this.nextPageKeyBuilder,
    this.errorBuilder,
  });
}
