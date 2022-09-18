part of 'base_paging_cubit.dart';

enum PagingState { ide, fetching, empty, fail }


@immutable
class BasePagingState<T> {
  final bool isFirstFetch;
  final List<T> list;
  final PagingState pagingState;

//<editor-fold desc="Data Methods">

  const BasePagingState({
    this.isFirstFetch = false,
    this.list = const [],
    this.pagingState = PagingState.ide,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BasePagingState &&
          runtimeType == other.runtimeType &&
          isFirstFetch == other.isFirstFetch &&
          list == other.list &&
          pagingState == other.pagingState);

  @override
  int get hashCode =>
      isFirstFetch.hashCode ^ list.hashCode ^ pagingState.hashCode;

  @override
  String toString() {
    return 'BasePagingState{' +
        ' isFirstFetch: $isFirstFetch,' +
        ' list: $list,' +
        ' pagingState: $pagingState,' +
        '}';
  }

  dynamic copyWith({
    bool? isFirstFetch,
    List<T>? list,
    PagingState? pagingState,
  }) {
    return BasePagingState<T>(
      isFirstFetch: isFirstFetch ?? this.isFirstFetch,
      list: list ?? this.list,
      pagingState: pagingState ?? this.pagingState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isFirstFetch': this.isFirstFetch,
      'list': this.list,
      'pagingState': this.pagingState,
    };
  }

  factory BasePagingState.fromMap(Map<String, dynamic> map) {
    return BasePagingState<T>(
      isFirstFetch: map['isFirstFetch'] as bool,
      list: map['list'] as List<T>,
      pagingState: map['pagingState'] as PagingState,
    );
  }

//</editor-fold>
}

