import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/widgets/refresh/app_pull_down_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef PagingListFetchFunc<T> = Future<List<T>> Function(
    int offset, int limit);

class PagingList<T> extends StatefulWidget {
  const PagingList({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
    this.shrinkWrap = false,
    required this.fetchListData,
    required this.itemBuilder,
    this.separatorBuilder,
    this.pageSize = BaseConstant.pageSizeDefault,
    this.pagingController,
    this.onlyOnePage = false,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.onEmpty,
    this.reverse = false,
    this.enablePullDown = true,
    this.delayFetch,
    this.addPageRequest = true,
    this.scrollController,
    this.firstPageErrorIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
  }) : super(key: key);

  final AppPagingController<int, T>? pagingController;

  final int pageSize;
  final ItemWidgetBuilder<dynamic> itemBuilder;
  final PagingListFetchFunc<T>? fetchListData;
  final IndexedWidgetBuilder? separatorBuilder;
  final WidgetBuilder? noItemsFoundIndicatorBuilder;
  final WidgetBuilder? noMoreItemsIndicatorBuilder;
  final WidgetBuilder? firstPageProgressIndicatorBuilder;
  final WidgetBuilder? newPageProgressIndicatorBuilder;
  final WidgetBuilder? firstPageErrorIndicatorBuilder;
  final WidgetBuilder? newPageErrorIndicatorBuilder;

  final VoidCallback? onEmpty;

  final Duration? delayFetch;
  final bool addPageRequest;

  // Paging Params
  final bool onlyOnePage;

  // ListView params
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  final bool reverse;
  final bool enablePullDown;

  @override
  State<PagingList> createState() => _PagingListState();
}

class _PagingListState<T> extends State<PagingList> {
  late final AppPagingController<int, T> _pagingController;
  PageRequestListener<int>? listener;
  bool isEmpty = false;
  bool isDelayDone = true;

  @override
  void initState() {
    _pagingController = (widget.pagingController ??
        AppPagingController(firstPageKey: 0)) as AppPagingController<int, T>;
    _pagingController.init(
        fetchListDataParam: widget.fetchListData as Future<List<T>> Function(
            int page, int pageSize),
        pageSizeParam: widget.pageSize);

    if (widget.delayFetch != null) {
      isDelayDone = false;
      Future.delayed(widget.delayFetch ?? const Duration(milliseconds: 0))
          .then((value) {
        isDelayDone = true;
        _fetchPage(0);
      });
    }
    if (widget.addPageRequest == true) {
      _pagingController.addPageRequestListener((pageKey) {
        if (isDelayDone) {
          _fetchPage(pageKey);
        }
      });
    }

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await widget.fetchListData?.call(pageKey, widget.pageSize);
      final isLastPage = (newItems?.length ?? 0) < widget.pageSize;

      if (isLastPage || widget.onlyOnePage) {
        _pagingController.appendLastPage(newItems as List<T>);
      } else {
        final nextPageKey = pageKey + (newItems?.length ?? 0);
        _pagingController.appendPage(newItems as List<T>, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isEmpty) return Gaps.empty;

    Widget pagedListView;
    pagedListView = PagedListView<int, T>.separated(
      scrollController: widget.scrollController,
      reverse: widget.reverse,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: widget.itemBuilder,
        firstPageProgressIndicatorBuilder:
            widget.firstPageProgressIndicatorBuilder ??
                (_) => AppLoading.defaultLoading(),
        newPageProgressIndicatorBuilder:
            widget.newPageProgressIndicatorBuilder ??
                (_) => AppLoading.defaultLoading(),
        firstPageErrorIndicatorBuilder: widget.firstPageErrorIndicatorBuilder ??
            (_) => const PageErrorNotify(),
        newPageErrorIndicatorBuilder: widget.newPageErrorIndicatorBuilder ??
            (_) => const PageErrorNotify(),
        noItemsFoundIndicatorBuilder: (context) {
          widget.onEmpty?.call();
          if (widget.noItemsFoundIndicatorBuilder != null) {
            return widget.noItemsFoundIndicatorBuilder?.call(context) ??
                Gaps.empty;
          }
          return const PageEmptyNotify();
        },
        noMoreItemsIndicatorBuilder:
            widget.noMoreItemsIndicatorBuilder ?? (_) => Gaps.empty,
      ),
      separatorBuilder: widget.separatorBuilder == null
          ? (_, index) => Gaps.empty
          : (context, index) {
              return (index + 1) == _pagingController.itemList?.length
                  ? Gaps.empty
                  : (widget.separatorBuilder?.call(context, index) ??
                      Gaps.empty);
            },
    );

    return AppPullDownRefresh(
      enable: widget.enablePullDown,
      refresh: () => _pagingController.refresh(),
      child: pagedListView,
    );
  }
}

class PageErrorNotify extends StatelessWidget {
  const PageErrorNotify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 'errorPleaseRetry'.tr.text.make().pDefault().centered();
  }
}

class PageEmptyNotify extends StatelessWidget {
  const PageEmptyNotify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 'contentIsUpdating'.tr.text.make().pDefault().centered();
  }
}
