// ignore_for_file: unnecessary_this

import 'package:kyo_base/imports/base_component_import.dart';
import 'package:intl/intl.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

const _vietnamese = 'aAeEoOuUiIdDyY';
final _vietnameseRegex = <RegExp>[
  RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
  RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
  RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
  RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
  RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
  RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
  RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
  RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
  RegExp(r'ì|í|ị|ỉ|ĩ'),
  RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
  RegExp(r'đ'),
  RegExp(r'Đ'),
  RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
  RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
];

extension IterableExt<T> on Iterable<T> {
  Iterable<T> superJoin(T separator) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return [];

    final _l = [iterator.current];
    while (iterator.moveNext()) {
      _l..add(separator)..add(iterator.current);
    }
    return _l;
  }
}

extension DataExtendNum on num? {
  bool get toBoolean => this == null ? false : this == 1;

  bool isNullOrEmpty() {
    return this == null;
  }

  bool isNotNullOrEmpty() {
    return this != null;
  }

  String toCountStr() {
    return this.isNullOrEmpty() ? '0' : (this! > 99 ? '99+' : this.toString());
  }

  String toThousandSeparator() {
    return '${PriceExtend.strToNumberFormat(this.toString())}';
  }

  String? intValidator() => this == null ? 'inputErrorMsg'.tr : null;

  String? toStringHideZero() =>
      this != null ? (this == 0 ? null : this.toString()) : null;

  String toStringWithZero() => this != null ? (this.toString()) : '0';

  String toStringWithZeroNegativeZero() =>
      this != null ? (this! >= 0 ? (this.toString()) : '0') : '0';
}

extension DataExtendBool on bool? {
  num get toNum => this == true ? 1 : 0;
}

extension DynamicExtend on dynamic {
  bool? toBoolean(){
    if (this is num){
      return this == null ? false : this == 1;
    }
    if (this is bool){
      return (this as bool);
    }
    return null;
  }
}

extension DataExtendString on String? {

  List<String>? getStrFromEnum<E extends Enum>(List<E> values) {
    return this
        ?.split(',')
        .mapAsList((strIndex) => values[int.parse(strIndex)].name);
  }

  List<String>? getStrFromEnumTr<E extends Enum>(List<E> values) {
    return this.isNullOrEmpty()
        ? null
        : this
            ?.split(',')
            .mapAsList((strIndex) => values[int.parse(strIndex)].name.tr);
  }

  T isEmptyOrValue<T>(T value) {
    if (this == null || this!.isEmpty) {
      return value;
    }
    return this as T;
  }

  bool get isEmptyOrNull => this == null || this!.isEmpty;

  String? capitalizeOnly() {
    if (this.isNullOrEmpty()) return null;
    return this
        ?.split(RegExp(r"\n"))
        .map((e) => e.capitalizeFirstOnly())
        .join('\n')
        .split(' ')
        .map((e) => e.capitalizeFirstOnly())
        .join(' ');
  }

  String? capitalizeFirstOnly() {
    if (this.isNullOrEmpty()) return null;
    return this![0].toUpperCase() + this!.substring(1);
  }

  String? unsigned() {
    if (this.isNullOrEmpty()) return this;

    var result = this;
    for (var i = 0; i < _vietnamese.length; ++i) {
      result = result?.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
    }
    return result;
  }

  String? unsignedLower() {
    return this.unsigned()?.toLowerCase();
  }

  bool isNullOrEmpty() => this == null || this?.trim() == '';

  bool isNotNullOrEmpty() => !isNullOrEmpty();

  String get toPhoneFormattedStr => this.isNullOrEmpty()
      ? ''
      : (formatAsPhoneNumber(this!, defaultMask: '0000 000 0000') ?? this!);

  String getDate() {
    return this?.substring(0, 10).split('-').reversed.join('/') ?? '';
  }

  String getDatetime() {
    String date = this?.substring(0, 10) ?? '';
    String time = this?.substring(11, 19) ?? '';
    var dateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(date + ' ' + time, true);
    var dateLocal = dateTime.toLocal();
    return dateLocal.toString().substring(0, 16);
  }
}

extension RangeExtension on int {
  List<int> toNum(int maxInclusive, {int step = 1}) =>
      [for (int i = this; i <= maxInclusive; i += step) i];
}

extension DateTimeExtension on DateTime {
  DateTime clearTime() {
    return DateTime(this.year, this.month, this.day);
  }

  DateTime setTime({int? newHour, int? newMinute}) {
    var time = toLocal();
    return DateTime(
        time.year,
        time.month,
        time.day,
        newHour ?? time.hour,
        newMinute ?? time.minute,
        time.second,
        time.millisecond,
        time.microsecond);
  }
}
