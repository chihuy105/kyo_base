import 'package:kyo_base/imports/base_component_import.dart';
import 'package:intl/intl.dart';

extension PriceDataExtendNum on num? {

  String? get toTwoDigit =>
      isNotNullOrEmpty() ? this?.toString().padLeft(2, '0') : null;

  num get toNumWithZero => this ?? 0;

  String? get billionToFullPrice =>
      this == null ? null : (this! * 1000000000).toString();

  String? get yearToFullDateBegin =>
      this == null ? null : '$this-01-01T00:00:00.000Z';

  String? get yearToFullYearEnd =>
      this == null ? null : '$this-12-31T23:59:59.000Z';
}

extension PriceDataExtendString on String? {

  String? get toFullFormattedPrice =>
      PriceExtend.strToFullFormattedPriceStr(this);

  num? get toNum => num.tryParse(this ?? '');

  num get toNumWithZero => num.tryParse(this ?? '') ?? 0;

  String? get withRequiredMark => this == null ? null : '$this *';
}

class PriceExtend {
  static final defaultPriceFormat = NumberFormat("###.#########", "vi_VN");
  static final twoFractionPriceFormat = NumberFormat("###.##", "vi_VN");
  static final fullWithUnitFormatted = NumberFormat.currency(
    locale: "vi_VN",
    symbol: "đ",
    decimalDigits: 0,
  );

  static final numberFormat = NumberFormat.decimalPattern("vi_VN");

  static String? strToNumberFormat(String? str) {
    if (str.isNullOrEmpty()) return null;
    try {
      return numberFormat.format(num.tryParse(str ?? ''));
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  static String? strToFullFormattedPriceStr(String? priceStr) {
    if (priceStr.isNullOrEmpty()) return null;
    try {
      return fullWithUnitFormatted.format(num.tryParse(priceStr ?? ''));
    } catch (e) {
      logger.e(e);
    }
    return null;
  }
}
