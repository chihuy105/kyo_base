import 'package:kyo_base/imports/base_component_import.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AppTabBarTheme {
  AppTabBarTheme._();

  static ThemeData getTabLight(BuildContext context,
      {double? borderRadius, TextStyle? labelStyle}) {
    return context.theme.copyWith(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      tabBarTheme: TabBarTheme(
        indicator: RectangularIndicator(
          topLeftRadius: borderRadius ?? Dimens.rad_max,
          topRightRadius: borderRadius ?? Dimens.rad_max,
          bottomLeftRadius: borderRadius ?? Dimens.rad_max,
          bottomRightRadius: borderRadius ?? Dimens.rad_max,
          color: context.themeColor.primaryLightest,
        ),
        labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        labelColor: context.theme.primaryColor,
        labelStyle: labelStyle ?? context.themeText.text,
        unselectedLabelColor: context.themeColorText.text,
        unselectedLabelStyle: context.themeText.text,
      ),
    );
  }

  static ThemeData getTabPrimary(BuildContext context,
      {double? borderRadius, TextStyle? labelStyle}) {
    return context.theme.copyWith(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      tabBarTheme: TabBarTheme(
        indicator: RectangularIndicator(
          topLeftRadius: borderRadius ?? Dimens.rad_max,
          topRightRadius: borderRadius ?? Dimens.rad_max,
          bottomLeftRadius: borderRadius ?? Dimens.rad_max,
          bottomRightRadius: borderRadius ?? Dimens.rad_max,
          color: context.themeColor.primaryLightest,
        ),
        labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        labelColor: context.theme.primaryColor,
        labelStyle: labelStyle ?? context.themeText.text,
        unselectedLabelColor: context.themeColorText.text,
        unselectedLabelStyle: context.themeText.text,
      ),
    );
  }

  static ThemeData getTabPrimarySquare(BuildContext context) {
    return getTabPrimary(context, borderRadius: Dimens.rad_XS, labelStyle: context.themeText.text.copyWith(fontWeight: FontWeight.w500));
  }

  static ThemeData getTabSecondary(BuildContext context) {
    return context.theme.copyWith(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      tabBarTheme: TabBarTheme(
        indicator: RectangularIndicator(
          topLeftRadius: Dimens.rad_max,
          topRightRadius: Dimens.rad_max,
          bottomLeftRadius: Dimens.rad_max,
          bottomRightRadius: Dimens.rad_max,
          color: context.theme.primaryColor,
        ),
        labelColor: context.theme.onPrimary(),
        labelStyle: context.themeText.text.copyWith(fontWeight: FontWeight.w700),
        unselectedLabelColor: context.themeColorText.textHint,
        unselectedLabelStyle: context.themeText.text.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
