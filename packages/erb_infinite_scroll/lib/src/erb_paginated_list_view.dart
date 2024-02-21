import 'package:erb_infinite_scroll/erb_infinite_scroll.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ERbPaginatedListView<T> extends StatefulWidget {
  const ERbPaginatedListView({
    required InfiniteScrollAutoDisposeProvider<T> provider,
    required this.itemBuilder,
    this.firstPageKey = 0,
    this.limit = 20,
    this.pullToRefresh = false,
    this.useSliver = false,
    this.enableInfiniteScroll = true,
    this.shrinkWrap = false,
    this.reverse = false,
    this.skeleton,
    this.numSkeletons = 4,
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

  const ERbPaginatedListView.keepAlive({
    required InfiniteScrollKeepAliveProvider<T> provider,
    required this.itemBuilder,
    this.firstPageKey = 0,
    this.limit = 20,
    this.pullToRefresh = false,
    this.useSliver = false,
    this.enableInfiniteScroll = true,
    this.shrinkWrap = false,
    this.reverse = false,
    this.skeleton,
    this.numSkeletons = 4,
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

  final InfiniteScrollKeepAliveProvider<T>? _provider;
  final InfiniteScrollAutoDisposeProvider<T>? _autoDisposeProvider;

  final int firstPageKey;
  final int limit;

  /// Choose if to add a Pull to refresh functionality
  /// This wil call `ref.refresh(provider)` internally
  /// Default [false]
  final bool pullToRefresh;

  /// If true, a SliverList is returned. Either [SliverList.builder] or
  /// [SliverList.separated]
  final bool useSliver;

  /// Choose if infinite scrolling functionality should be enabled
  /// Default [true]
  final bool enableInfiniteScroll;

  /// The number of remaining invisible items that should trigger a new fetch.
  final int? invisibleItemsThreshold;

  /// Whether to enable [shrinkWrap] property on [ListView]. Defaults to false.
  final bool shrinkWrap;

  /// Whether to enable [reverse] property on [ListView]. Defaults to false.
  final bool reverse;

  /// If supplied, a skeleton loading animation will be showed initially. You
  /// just need to pass the item widget with some dummy data. A skeleton will be
  /// created automatically using *skeletonizer* library
  final Widget? skeleton;

  ///How many skeletons to show int the initial loading. Ignored if skeleton is
  ///not provided.
  final int numSkeletons;

  final ItemWidgetBuilder<T> itemBuilder;

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
  State<ERbPaginatedListView<T>> createState() =>
      _ERbPaginatedListViewState<T>();
}

class _ERbPaginatedListViewState<T> extends State<ERbPaginatedListView<T>> {
  get _provider => widget._provider ?? widget._autoDisposeProvider!;
  List<Widget> get skeletons =>
      List.generate(widget.numSkeletons, (_) => widget.skeleton!);

  @override
  Widget build(BuildContext context) {
    return ERbPagedBuilder(
      provider: _provider,
      itemBuilder: widget.itemBuilder,
      firstPageKey: widget.firstPageKey,
      limit: widget.limit,
      pullToRefresh: widget.useSliver ? false : widget.pullToRefresh,
      enableInfiniteScroll: widget.enableInfiniteScroll,
      invisibleItemsThreshold: widget.invisibleItemsThreshold,
      firstPageErrorIndicatorBuilder: widget.firstPageErrorIndicatorBuilder,
      firstPageProgressIndicatorBuilder:
          widget.firstPageProgressIndicatorBuilder != null ||
                  widget.skeleton != null
              ? (ctx, controller) => firstLoadingBuilder(context, controller)
              : null,
      noItemsFoundIndicatorBuilder: widget.noItemsFoundIndicatorBuilder,
      newPageErrorIndicatorBuilder: widget.newPageErrorIndicatorBuilder,
      newPageProgressIndicatorBuilder: widget.newPageProgressIndicatorBuilder,
      noMoreItemsIndicatorBuilder: widget.noMoreItemsIndicatorBuilder,
      pagedBuilder: _listBuilder,
    );
  }

  Widget _listBuilder(PagingController<int, T> pagingController,
      PagedChildBuilderDelegate<T> builder) {
    return widget.useSliver
        ? PagedSliverList(
            pagingController: pagingController,
            builderDelegate: builder,
          )
        : PagedListView(
            pagingController: pagingController,
            builderDelegate: builder,
          );
  }

  Widget firstLoadingBuilder(
      BuildContext context, PagingController controller) {
    if (widget.firstPageProgressIndicatorBuilder != null) {
      return widget.firstPageProgressIndicatorBuilder!
          .call(context, controller);
    }
    if (widget.skeleton != null) {
      return buildShimmer();
    }
    return const SizedBox.shrink();
  }

  Widget buildShimmer() {
    return Skeletonizer(
      child: Column(
        children: skeletons,
      ),
    );
  }
}
