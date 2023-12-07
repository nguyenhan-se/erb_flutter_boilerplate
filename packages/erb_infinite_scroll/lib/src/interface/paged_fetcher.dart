typedef LoadFunction<ItemType> = Future<List<ItemType>?> Function(
    int page, int limit);

typedef NextPageKeyBuilder<ItemType> = int? Function(
    List<ItemType>? lastItems, int page, int limit);

class NextPageKeyBuilderDefault<ItemType> {
  static NextPageKeyBuilder<dynamic> mysqlPagination =
      (List<dynamic>? lastItems, int page, int limit) {
    return (lastItems == null || lastItems.length < limit) ? null : (page + 1);
  };
}

///Abstract class for defining the the Notifier interface.
///Each provider should implement this class
abstract interface class PagedNotifier<ItemType> {
  Future<List<ItemType>?> load(int page, int limit);
}

class PagedFetcher<ItemType> {
  /// Load function
  final LoadFunction<ItemType> load;
  final NextPageKeyBuilder<ItemType> nextPageKeyBuilder =
      NextPageKeyBuilderDefault.mysqlPagination;

  /// A builder for providing a custom error string
  final dynamic Function(dynamic error)? errorBuilder;

  PagedFetcher({
    required this.load,
    this.errorBuilder,
    NextPageKeyBuilder<ItemType>? nextPageKeyBuilder,
  }) {
    if (nextPageKeyBuilder != null) {
      nextPageKeyBuilder = nextPageKeyBuilder;
    }
  }
}
