import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'interface/paged_fetcher.dart';
import 'interface/paged_state.dart';

mixin KeepAlivePagedMixin<ItemType> on Notifier<PagedState<ItemType>>
    implements PagedNotifier<ItemType> {
  late PagedFetcher<ItemType> _dataFetcher;

  PagedState<ItemType> init({
    required PagedFetcher<ItemType> dataFetcher,
  }) {
    _dataFetcher = dataFetcher;
    return PagedState<ItemType>();
  }

  @override
  Future<List<ItemType>?> load(page, int limit) async {
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
          nextPageKey: _dataFetcher.nextPageKeyBuilder
                  ?.call(records, page, limit) ??
              NextPageKeyBuilderDefault.mysqlPagination(records, page, limit),
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
