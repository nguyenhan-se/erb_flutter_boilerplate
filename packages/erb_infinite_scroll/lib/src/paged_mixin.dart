import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'interface/paged_fetcher.dart';
import 'interface/paged_state.dart';

mixin PagedMixin<PageKeyType, ItemType>
    on AutoDisposeNotifier<PagedState<PageKeyType, ItemType>>
    implements PagedNotifier<PageKeyType, ItemType> {
  late PagedFetcher<PageKeyType, ItemType> _dataFetcher;

  PagedState<PageKeyType, ItemType> init({
    required PagedFetcher<PageKeyType, ItemType> dataFetcher,
  }) {
    _dataFetcher = dataFetcher;
    return PagedState<PageKeyType, ItemType>();
  }

  @override
  Future<List<ItemType>?> load(PageKeyType page, int limit) async {
    if (state.previousPageKeys.contains(page)) {
      await Future.delayed(const Duration(seconds: 0), () {
        state = state.copyWith();
      });
      return state.records;
    }

    try {
      final records = await _dataFetcher.load(page, limit);

      state = state.copyWith(
          records: [
            ...(state.records ?? <ItemType>[]),
            ...(records ?? <ItemType>[])
          ],
          nextPageKey: _dataFetcher.nextPageKeyBuilder(records, page, limit),
          previousPageKeys: {...state.previousPageKeys, page}.toList());
      return records;
    } catch (e) {
      state = state.copyWith(
          error: _dataFetcher.errorBuilder != null
              ? _dataFetcher.errorBuilder!(e)
              : 'An error occurred. Please try again.');
    }

    return null;
  }
}
