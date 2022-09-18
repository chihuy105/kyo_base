import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/cupertino.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AppTheme {
  static ThemeData getTheme({bool isDark = false}) {
    var colorScheme = AppThemeExtension.colorSchemaFrom(isDark: isDark);
    final Color onPrimarySurfaceColor = isDark ? colorScheme.onSurface : colorScheme.onPrimary;

    var textTheme = AppThemeTextExtension.getTextTheme(isDark: isDark);
    return ThemeData(
      fontFamily: 'Inter',
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: colorScheme.primary,
        scaffoldBackgroundColor: colorScheme.background,
      ),
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      bottomAppBarColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      backgroundColor: colorScheme.background,
      dialogBackgroundColor: colorScheme.background,
      indicatorColor: onPrimarySurfaceColor,
      errorColor: colorScheme.error,
      textTheme: textTheme,
      applyElevationOverlayColor: isDark,
      hintColor: AppThemeTextColorExtension.form(isDark).textHint,
      dividerTheme: DividerThemeData(
        color: AppThemeExtension.form(isDark).divider,
        thickness: 1
      ),

      tabBarTheme: TabBarTheme(
        indicator: RectangularIndicator(
          topLeftRadius: Dimens.rad_max,
          topRightRadius: Dimens.rad_max,
          bottomLeftRadius: Dimens.rad_max,
          bottomRightRadius: Dimens.rad_max,
          horizontalPadding: 0,
          color: AppThemeExtension.form(isDark).primaryLightest
        ),
        labelColor: colorScheme.primary,
        labelStyle: AppThemeTextExtension.form(isDark).text.copyWith(
          fontWeight: FontWeight.w600
        ),
        unselectedLabelColor: AppThemeTextColorExtension.form(isDark).textGray,
        unselectedLabelStyle: AppThemeTextExtension.form(isDark).text.copyWith(
            fontWeight: FontWeight.w400
        )
      ),

      sliderTheme: SliderThemeData(
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
        inactiveTrackColor: AppThemeExtension.form(isDark).gray6
      ),

      extensions: [
        AppThemeExtension.form(isDark),
        AppThemeTextExtension.form(isDark),
        AppThemeTextColorExtension.form(isDark),
      ],
    );
  }
}

