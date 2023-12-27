import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'interface/paged_fetcher.dart';
import 'interface/paged_state.dart';

mixin PagedMixin<ItemType> on AutoDisposeNotifier<PagedState<ItemType>>
    implements PagedNotifier<ItemType> {
  late PagedFetcher<ItemType> _fetcher;

  PagedState<ItemType> init({
    required PagedFetcher<ItemType> fetcher,
  }) {
    _fetcher = fetcher;
    return PagedState<ItemType>();
  }

  PagedFetcher<ItemType> get fetcher => _fetcher;

  @override
  Future<List<ItemType>?> load(int page, int limit) async {
    if (state.previousPageKeys.contains(page)) {
      await Future.delayed(const Duration(seconds: 0), () {
        state = state.copyWith();
      });
      return state.records;
    }

    try {
      final records = await _fetcher.load(page, limit);

      state = state.copyWith(
          records: [
            ...(state.records ?? <ItemType>[]),
            ...(records ?? <ItemType>[])
          ],
          nextPageKey: _fetcher.nextPageKeyBuilder
                  ?.call(records, page, limit) ??
              NextPageKeyBuilderDefault.mysqlPagination(records, page, limit),
          previousPageKeys: {...state.previousPageKeys, page}.toList());
      return records;
    } catch (e) {
      state = state.copyWith(
          error: _fetcher.errorBuilder != null
              ? _fetcher.errorBuilder!(e)
              : 'An error occurred. Please try again.');
    }

    return null;
  }
}
