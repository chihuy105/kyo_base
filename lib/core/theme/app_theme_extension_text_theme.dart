import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter_html/flutter_html.dart';

extension AppThemeTextContextExtend on BuildContext {
  AppThemeTextExtension get themeText =>
      Theme.of(this).extension<AppThemeTextExtension>() ??
      AppThemeTextExtension.light;
}

@immutable
class AppThemeTextExtension extends ThemeExtension<AppThemeTextExtension> {
  const AppThemeTextExtension({
    required this.text,
    required this.textHint,
  });

  static TextStyle defaultText = TextStyle(
    color: AppThemeTextColorExtension.light.text,
    fontSize: Dimens.text,
  );

  static AppThemeTextExtension dark = AppThemeTextExtension(
    text: defaultText,
    textHint: defaultText.copyWith(
      color: AppThemeTextColorExtension.dark.textHint,
    ),
  );

  static final AppThemeTextExtension light = AppThemeTextExtension(
    text: const TextStyle(),
    textHint: TextStyle(
      color: AppThemeTextColorExtension.light.textHint,
    ),
  );

  final TextStyle text;
  final TextStyle textHint;

  @override
  AppThemeTextExtension copyWith({TextStyle? brandColor, TextStyle? danger}) {
    return AppThemeTextExtension(
      text: brandColor ?? text,
      textHint: brandColor ?? textHint,
    );
  }

  @override
  AppThemeTextExtension lerp(
      ThemeExtension<AppThemeTextExtension>? other, double t) {
    if (other is! AppThemeTextExtension) {
      return this;
    }
    return AppThemeTextExtension(
      text: TextStyle.lerp(text, other.text, t) ?? text,
      textHint: TextStyle.lerp(textHint, other.textHint, t) ?? textHint,
    );
  }

  factory AppThemeTextExtension.of(BuildContext context) {
    return Theme.of(context).extension as AppThemeTextExtension;
  }

  factory AppThemeTextExtension.form(bool isDark) {
    return isDark ? AppThemeTextExtension.dark : AppThemeTextExtension.light;
  }

  static TextTheme getTextTheme({bool isDark = false}) {
    var textDynamic = AppThemeTextExtension.form(isDark).text.copyWith(
          color: isDark ? AppColor.text.dark : AppColor.text.light,
        );
    return TextTheme(
      bodyText2: textDynamic,
      bodyText1: textDynamic,
      headline1: textDynamic.copyWith(
          fontSize: 42,
          letterSpacing: -1.5,
          fontWeight: FontWeight.w500,
          color: AppColor.textHeading.form(isDark)),
      headline2: textDynamic.copyWith(
          fontSize: 34,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w500,
          color: AppColor.textHeading.form(isDark)),
      headline3: textDynamic.copyWith(
          fontSize: 30,
          letterSpacing: 0,
          color: AppColor.textHeading.form(isDark)),
      headline4: textDynamic.copyWith(
          fontSize: 26,
          letterSpacing: 0.25,
          color: AppColor.textHeading.form(isDark)),
      headline5: textDynamic.copyWith(
          fontSize: 22,
          letterSpacing: 0,
          fontWeight: FontWeight.w700,
          color: AppColor.textHeading.form(isDark)),
      headline6: textDynamic.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColor.textHeading.form(isDark)),
      subtitle1: textDynamic.copyWith(fontSize: 18, letterSpacing: 0.15),
      subtitle2: textDynamic.copyWith(
          fontSize: 16, letterSpacing: 0.1, fontWeight: FontWeight.w500),
      caption: textDynamic.copyWith(
          fontSize: 14, letterSpacing: 0.4, color: AppColor.textHint.dynamic),
      overline: textDynamic.copyWith(fontSize: 14, letterSpacing: 1.5),
      button: textDynamic.copyWith(fontWeight: FontWeight.w700),
    );
  }

  //! The order of the key is override from top to bottom
  static Map<String, Style> getHtmlStyle(BuildContext context) {
    return {
      ...Style.fromThemeData(context.theme),
      "body": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      "html": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      "p": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      "strong": Style(textAlign: TextAlign.center),
      "li": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      "li:not(:last-child)": Style(
        padding: const EdgeInsets.only(bottom: 6, left: 4),
      ),
      "ul": Style(
        listStylePosition: ListStylePosition.OUTSIDE,
      ),
      "table": Style(
        backgroundColor:
            Theme.of(context).unselectedWidgetColor.withOpacity(0.1),
        // border: Border.all(color: Theme.of(context).hintColor),
      ),
      "tr": Style(
        border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
        // border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      "th": Style(
        padding: const EdgeInsets.all(6),
        backgroundColor: Colors.grey,
      ),
      "td": Style(
        padding: const EdgeInsets.all(6),
      ),
    };
  }

  static Map<String, Style> getHtmlDescriptionStyle(BuildContext context) {
    return {
      "p": Style(
          textAlign: TextAlign.justify,
          maxLines: 2,
          textOverflow: TextOverflow.ellipsis,
          fontSize: FontSize.medium),
    };
  }
}
