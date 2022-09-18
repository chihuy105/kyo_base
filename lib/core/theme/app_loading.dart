import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/cupertino.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AppLoading {
  AppLoading._();

  static Widget defaultLoading({
    bool isLoading = true,
    bool center = true,
    double? strokeWidth,
    Color? color,
  }) {
    var loading = isLoading
        ? const CupertinoActivityIndicator()
        : Gaps.empty;

    return center ? loading.centered() : loading;
  }

  static Widget materialLoading({
    bool isLoading = true,
    bool center = true,
    double? strokeWidth,
    Color? color,
  }) {
    var loading = isLoading
        ? CircularProgressIndicator(color: color)
        : Gaps.empty;

    return center ? loading.centered() : loading;
  }

  static Widget defaultLoadingBox(
      {bool isLoading = true,
      double? strokeWidth,
      Color? color,
      double size = 40,
      double? height,
      double? width,
      bool center = true}) {
    if (!isLoading) return Gaps.empty;

    return SizedBox(
        height: height ?? size,
        width: width ?? size,
        child: AppLoading.defaultLoading(
          isLoading: isLoading,
          strokeWidth: strokeWidth,
          color: color,
          center: center,
        ));
  }

  static Widget materialLoadingBox(BuildContext context,
      {bool isLoading = true,
      double? strokeWidth,
      Color? color,
      double size = 40,
      double? height,
      double? width,
      bool center = true}) {
    if (!isLoading) return Gaps.empty;

    return SizedBox(
        height: height ?? size,
        width: width ?? size,
        child: AppLoading.materialLoading(
          isLoading: isLoading,
          strokeWidth: strokeWidth,
          color: color ?? context.theme.onPrimary(),
          center: center,
        ));
  }
}
