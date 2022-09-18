// ignore_for_file: prefer_is_empty

import 'package:kyo_base/imports/base_component_import.dart';

extension RxMapExtend<K, V> on RxMap<K, V>? {
  RxMap<K, V>? update(Map<K, V>? list) {
    if (list.isNullOrEmpty() || this == null) {
      return this;
    }

    this!.clear();
    this!.addAll(list!);
    this!.refresh();
    return this;
  }
}

extension MapExtend<K, V> on Map<K, V>? {
  bool isNullOrEmpty() {
    if (this == null || this?.length == 0) return true;
    return false;
  }

  List<T>? mapAsList<T>(T Function(K key, V value) mapFunc) {
    if (isNullOrEmpty()) {
      return [];
    }

    return this
        ?.entries
        .map<T>((entry) => mapFunc(entry.key, entry.value))
        .toList();
  }
}

extension RxListExtend<T> on RxList<T>? {
  RxList<T>? update(List<T>? list) {
    if (this == null) {
      return this;
    }
    this!.clear();
    this!.addAll(list!);
    // this!.refresh();
    return this;
  }
}

extension ListExtend<T> on List<T>? {
  T? getOrNull(int index) {
    if (this == null || index < 0) return null;
    if (index < this!.length) return this![index];
    return null;
  }

  Iterable<T> withoutLast() {
    if (isNullOrEmpty()) return [];

    return this!.sublist(0, this!.length - 1);
  }
}

extension IterableBasics<E> on Iterable<E>? {
  // ignore: use_function_type_syntax_for_parameters
  List<T> mapAsList<T>(T f(E item)) => this?.map(f).toList() ?? [];

  bool isNullOrEmpty() {
    if (this == null || this?.length == 0) return true;
    return false;
  }

  bool isNotNullOrEmpty() {
    return !isNullOrEmpty();
  }

  Iterable<E> filter(bool Function(E item) conditionMethod) {
    return this?.where(conditionMethod) ?? [];
  }

  E? find(bool Function(E item) conditionMethod) {
    return filterAsList(conditionMethod).firstOrNull();
  }

  List<E> filterAsList(bool Function(E item) conditionMethod) {
    return filter(conditionMethod).toList();
  }

  List<E> filterAsListIndex(bool Function(E item, int index) conditionMethod) {
    var i = 0;
    if (isNullOrEmpty()) {
      return [];
    }
    return filter((e) => conditionMethod(e, i++)).toList();
  }

  List<U> mapAsListIndexed<U>(
      U Function(E currentValue, int index) transformer,
      ) {
    return mapIndexed(transformer)?.toList() ?? [];
  }

  List<E> searchList(String? searchText, String? Function(E item) mapping) {
    return filterAsList((item) {
      return (mapping(item)
          ?.unsignedLower()
          ?.contains(searchText?.unsignedLower() ?? '') ??
          false);
    });
  }

  // use "Nill" to avoid conflict name
  E? firstOrNull() {
    if (this?.length == 0) return null;
    return firstOrElse(() => null as E);
  }

  E? lastOrNull() {
    if (this?.length == 0) return null;
    return lastOrElse(() => null as E);
  }

  E? firstOrElse(E Function() orElse) {
    if (this?.length == 0) return null;
    return this?.firstWhere((_) => true, orElse: orElse);
  }

  E? lastOrElse(E Function() orElse) {
    if (this?.length == 0) return null;
    return this?.lastWhere((_) => true, orElse: orElse);
  }

  Iterable<T>? mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    if (isNullOrEmpty()) {
      return null;
    }
    return this!.map((e) => f(e, i++));
  }

  void forEachIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    if (isNullOrEmpty()) {
      return;
    }
    return this!.forEach((e) => f(e, i++));
  }
}
