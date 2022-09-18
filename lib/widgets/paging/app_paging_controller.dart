import 'package:kyo_base/imports/base_component_import.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AppPagingController<PageKeyType, ItemType>
    extends PagingController<PageKeyType, ItemType> {
  AppPagingController({required PageKeyType firstPageKey})
      : super(firstPageKey: firstPageKey);

  Future<List<ItemType>> Function(PageKeyType page, int pageSize)?
      fetchListData;
  int? pageSize;

  void init(
      {required Future<List<ItemType>> Function(PageKeyType page, int pageSize)
          fetchListDataParam,
      required int pageSizeParam}) {
    fetchListData = fetchListDataParam;
    pageSize = pageSizeParam;
  }

  void clearAndRefresh() {
    itemList = [];
    refresh();
  }

  void refreshSilent({List<ItemType>? updateItemList, int? limit}) {
    if (updateItemList.isNotNullOrEmpty()){
      itemList = [...updateItemList ?? []];
      return;
    }

    var itemCurrentLength = (itemList?.length ?? 0) > 0? itemList?.length: null;

    fetchListData?.call(0 as PageKeyType, limit ?? itemCurrentLength ?? pageSize ?? BaseConstant.pageSizeDefault).then((value) {
      itemList = [...value];
    });
  }

  void refreshList(){
    itemList = [...?itemList];
  }

  bool updateItem({
    required ItemType? item,
    required bool Function(ItemType? oldItem, ItemType? item) checkFunction,
    bool? addHeadNotFound,
    bool? addTailNotFound,
  }) {
    logger.i('updateItem ${item.toString()}');

    if (itemList.isNullOrEmpty() || item == null) return false;

    var indexUpdate =
        itemList?.indexWhere((oldItem) => checkFunction(oldItem, item));
    if ((indexUpdate ?? -1) > -1) {
      itemList![indexUpdate!] = item;
      itemList = [...?itemList];
      return true;
    } else if (addHeadNotFound == true) {
      logger.i('addHeadNotFound');
      itemList = [item, ...?itemList];
    } else if (addTailNotFound == true) {
      logger.i('addTailNotFound');
      itemList = [...?itemList, item];
    }

    logger.i('updateItem false');
    return false;
  }
}
