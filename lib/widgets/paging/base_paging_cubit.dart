import 'package:kyo_base/imports/base_component_import.dart';

part 'base_paging_state.dart';

/// This bloc will check all the case for a paging logic
/// 1. Return data
/// 2. Return empty data
/// 3. Return Error when crash
/// 4. Load by page
///
abstract class BasePagingCubit<T, S extends BasePagingState<T>>
    extends Cubit<BasePagingState<T>> {
  int page = 1;
  final pageSize = 10;

  BasePagingCubit(S initialState) : super(initialState);

  // BasePagingCubit()
  //     : super(const BasePagingState());

  Future<dynamic> fetchListData({required int page, required int pageSize});

  bool isLoading() {
    return state.pagingState == PagingState.fetching;
  }

  Future<void> loadData() async {
    if (state.pagingState == PagingState.fetching) {
      return;
    }
    try {
      emit(state.copyWith(
          isFirstFetch: page == 1, pagingState: PagingState.fetching));

      List<T> fetchList = await fetchListData(page: page, pageSize: pageSize);
      ++page;

      final List<T> list = state.list;

      emit(state.copyWith(
          list: [...list, ...fetchList], pagingState: PagingState.ide));
    } catch (e) {
      logger.e('loadData fail');
      logger.e(e);
      emit(state.copyWith(pagingState: PagingState.fail));
    }
  }
}
