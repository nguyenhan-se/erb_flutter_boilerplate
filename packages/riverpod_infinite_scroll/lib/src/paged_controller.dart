import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod_infinite_scroll.dart';

typedef NextPageKeyBuilder<PageKeyType, ItemType> = PageKeyType? Function(
    List<ItemType>? lastItems, PageKeyType page, int limit);

mixin PaginatedDataMixin<PageKeyType, ItemType>
    on AutoDisposeAsyncNotifier<List<ItemType>> {
  late PagedState<PageKeyType, ItemType> _pagedState;

  // @override
  // FutureOr<PagedState<PageKeyType, ItemType>> build() {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

  Future<List<ItemType>?> load(PageKeyType page, int limit) {
    // _dataFetcher = dataFetcher;

    // TODO: implement load
    throw UnimplementedError();
  }
}
