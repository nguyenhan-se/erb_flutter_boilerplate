import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'interface/paged_state.dart';
import 'keep_alive_paged_mixin.dart';
import 'paged_mixin.dart';

typedef PagedBuilder<PageKeyType, ItemType> = Widget Function(
  PagingController<PageKeyType, ItemType> controller,
  PagedChildBuilderDelegate<ItemType> builder,
);

typedef InfiniteScrollAutoDisposeProvider<PageKeyType, ItemType>
    = AutoDisposeNotifierProvider<PagedMixin<PageKeyType, ItemType>,
        PagedState<PageKeyType, ItemType>>;

typedef InfiniteScrollKeepAliveProvider<PageKeyType, ItemType>
    = NotifierProvider<KeepAlivePagedMixin<PageKeyType, ItemType>,
        PagedState<PageKeyType, ItemType>>;

class ERbPagedBuilder<PageKeyType, ItemType> extends ConsumerStatefulWidget {
  const ERbPagedBuilder({
    required InfiniteScrollAutoDisposeProvider<PageKeyType, ItemType> provider,
    required this.pagedBuilder,
    required this.itemBuilder,
    required this.firstPageKey,
    this.limit = 20,
    this.pullToRefresh = false,
    this.enableInfiniteScroll = true,
    this.invisibleItemsThreshold,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    super.key,
  })  : _autoDisposeProvider = provider,
        _provider = null;

  const ERbPagedBuilder.keepAlive({
    required InfiniteScrollKeepAliveProvider<PageKeyType, ItemType> provider,
    required this.pagedBuilder,
    required this.itemBuilder,
    required this.firstPageKey,
    this.limit = 20,
    this.pullToRefresh = false,
    this.enableInfiniteScroll = true,
    this.invisibleItemsThreshold,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    super.key,
  })  : _provider = provider,
        _autoDisposeProvider = null;

  final InfiniteScrollKeepAliveProvider<PageKeyType, ItemType>? _provider;
  final InfiniteScrollAutoDisposeProvider<PageKeyType, ItemType>?
      _autoDisposeProvider;

  final PageKeyType firstPageKey;
  final int limit;

  /// Choose if to add a Pull to refresh functionality
  /// This wil call `ref.refresh(provider)` internally
  /// Default [false]
  final bool pullToRefresh;

  /// Choose if infinite scrolling functionality should be enabled
  /// Default [true]
  final bool enableInfiniteScroll;

  /// The number of remaining invisible items that should trigger a new fetch.
  final int? invisibleItemsThreshold;

  final ItemWidgetBuilder<ItemType> itemBuilder;
  final PagedBuilder<PageKeyType, ItemType> pagedBuilder;

  final Widget Function(BuildContext context, PagingController controller)?
      firstPageErrorIndicatorBuilder;
  final Widget Function(BuildContext context, PagingController controller)?
      firstPageProgressIndicatorBuilder;
  final Widget Function(BuildContext context, PagingController controller)?
      noItemsFoundIndicatorBuilder;
  final Widget Function(BuildContext context, PagingController controller)?
      newPageErrorIndicatorBuilder;
  final Widget Function(BuildContext context, PagingController controller)?
      newPageProgressIndicatorBuilder;
  final Widget Function(BuildContext context, PagingController controller)?
      noMoreItemsIndicatorBuilder;

  @override
  ConsumerState<ERbPagedBuilder<PageKeyType, ItemType>> createState() =>
      _ERbPagedBuilderState<PageKeyType, ItemType>();
}

class _ERbPagedBuilderState<PageKeyType, ItemType>
    extends ConsumerState<ERbPagedBuilder<PageKeyType, ItemType>> {
  late final PagingController<PageKeyType, ItemType> _pagingController;

  get _provider => widget._provider ?? widget._autoDisposeProvider!;

  @override
  void initState() {
    // Instantiate the [PagingController]
    _pagingController = PagingController<PageKeyType, ItemType>(
        firstPageKey: widget.firstPageKey,
        invisibleItemsThreshold: widget.invisibleItemsThreshold);

    // Redirect every page request to the [StateNotifier]
    _pagingController.addPageRequestListener(_loadFromProvider);

    super.initState();
  }

  void _loadFromProvider(PageKeyType pageKey) {
    if (pageKey != widget.firstPageKey && !widget.enableInfiniteScroll) {
      return _updatePagingState(
        ref
            .read<PagedState<PageKeyType, ItemType>>(_provider)
            .copyWith(nextPageKey: null),
      );
    }
    ref.read((_provider).notifier).load(pageKey, widget.limit);
  }

  void _updatePagingState(PagedState<PageKeyType, ItemType> state) {
    _pagingController.value = PagingState(
      error: state.error,
      itemList: state.records,
      nextPageKey: state.nextPageKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This listen to [StateNotiefer] change and reflect those changes to the [PagingController]
    ref.listen<PagedState<PageKeyType, ItemType>>(
      _provider,
      (_, next) => _updatePagingState(next),
    );
    // Allow possibility to customize indicators
    final itemBuilder = PagedChildBuilderDelegate<ItemType>(
      itemBuilder: widget.itemBuilder,
      firstPageErrorIndicatorBuilder:
          widget.firstPageErrorIndicatorBuilder != null
              ? (ctx) =>
                  widget.firstPageErrorIndicatorBuilder!(ctx, _pagingController)
              : null,
      firstPageProgressIndicatorBuilder: widget
                  .firstPageProgressIndicatorBuilder !=
              null
          ? (ctx) =>
              widget.firstPageProgressIndicatorBuilder!(ctx, _pagingController)
          : null,
      noItemsFoundIndicatorBuilder: widget.noItemsFoundIndicatorBuilder != null
          ? (ctx) =>
              widget.noItemsFoundIndicatorBuilder!(ctx, _pagingController)
          : null,
      newPageErrorIndicatorBuilder: widget.newPageErrorIndicatorBuilder != null
          ? (ctx) =>
              widget.newPageErrorIndicatorBuilder!(ctx, _pagingController)
          : null,
      newPageProgressIndicatorBuilder: widget.newPageProgressIndicatorBuilder !=
              null
          ? (ctx) =>
              widget.newPageProgressIndicatorBuilder!(ctx, _pagingController)
          : null,
      noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder != null
          ? (ctx) => widget.noMoreItemsIndicatorBuilder!(ctx, _pagingController)
          : null,
    );

    // return a [PagedBuilder]
    var pagedBuilder = widget.pagedBuilder(_pagingController, itemBuilder);

    // Add pull to refresh functionality if specified
    if (widget.pullToRefresh) {
      pagedBuilder = RefreshIndicator(
          onRefresh: () async => ref.refresh(_provider), child: pagedBuilder);
    }

    return pagedBuilder;
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
