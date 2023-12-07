import 'dart:math';

import 'package:collection/collection.dart';

const undefined = Object();

class PagedState<ItemType> {
  final List<ItemType>? records;
  final dynamic error;
  final int? nextPageKey;
  final List<int> previousPageKeys;

  const PagedState({
    this.records,
    this.error,
    this.nextPageKey,
    this.previousPageKeys = const [],
  });

  PagedState<ItemType> copyWith({
    List<ItemType>? records,
    dynamic error,
    int? nextPageKey,
    List<int>? previousPageKeys,
  }) {
    return PagedState<ItemType>(
      records: records ?? this.records,
      error: error == undefined ? this.error : error,
      nextPageKey: nextPageKey ?? this.nextPageKey,
      previousPageKeys: previousPageKeys ?? this.previousPageKeys,
    );
  }

  @override
  String toString() {
    return 'PagedState(records: $records, error: $error, nextPageKey: $nextPageKey, previousPageKeys: $previousPageKeys)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PagedState &&
            const DeepCollectionEquality().equals(other.records, records) &&
            const DeepCollectionEquality().equals(other.error, e) &&
            const DeepCollectionEquality()
                .equals(other.nextPageKey, nextPageKey) &&
            const DeepCollectionEquality()
                .equals(other.previousPageKeys, previousPageKeys));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(records),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(nextPageKey),
      const DeepCollectionEquality().hash(previousPageKeys));
}
