import 'package:kyo_base/imports/base_component_import.dart';

class ScreenUtils {
  ScreenUtils._();

  static double getBannerHighByRatio({required double ratio}) {
    return ScreenUtils.getPercentWidth(percent: 1) / ratio;
  }

  static double heightFormRatio({required double ratio}) {
    return getPercentWidth(percent: 1) / ratio;
  }

  static double getPercentWidth({required double percent, double? maxValue}) {
    double rWidth;
    double preWidth = Get.width;
    double preHeight = Get.height;
    if (preWidth > preHeight) {
      rWidth = preHeight * percent;
    } else {
      rWidth = preWidth * percent;
    }

    if (maxValue != null) {
      return (rWidth >= maxValue) ? maxValue : rWidth;
    } else {
      return rWidth;
    }
  }

  static double getPercentHeight({required double percent, double? maxValue}) {
    double rHeight;
    double preWidth = Get.width;
    double preHeight = Get.height;
    if (preWidth > preHeight) {
      rHeight = preWidth * percent;
    } else {
      rHeight = preHeight * percent;
    }

    if (maxValue != null) {
      return (rHeight >= maxValue) ? maxValue : rHeight;
    } else {
      return rHeight;
    }
  }

  static double getStatusBarHeight() => Get.mediaQuery.padding.top;
}
