import 'package:kyo_base/imports/base_component_import.dart';

extension AppThemeTextColorContextExtend on BuildContext {
  AppThemeTextColorExtension get themeColorText =>
      Theme.of(this).extension<AppThemeTextColorExtension>() ??
      AppThemeTextColorExtension.light;
}

@immutable
class AppThemeTextColorExtension extends ThemeExtension<AppThemeTextColorExtension> {

  const AppThemeTextColorExtension({
    required this.text,
    required this.textLink,
    required this.textGray,
    required this.textDark,
    required this.textHint,
    required this.textHintLight,
    required this.textHeading,
    required this.textDisable,
  });

  static const AppThemeTextColorExtension dark = AppThemeTextColorExtension(
    text: Color(0xFF242424),
    textLink: Color(0xFF5587EA),
    textGray: Color(0xFF444444),
    textDark: Color(0xFF444444),
    textHint: Color(0xFF9B9B9B),
    textHintLight: Color(0xFFE4E4E4),
    textHeading: Color(0xFF081F32),
    textDisable: Color(0xFFD4E2FA),
  );

  static const AppThemeTextColorExtension light = AppThemeTextColorExtension(
    text: Color(0xFF242424),
    textLink: Color(0xFF5587EA),
    textGray: Color(0xFF444444),
    textDark: Color(0xFF444444),
    textHint: Color(0xFF9B9B9B),
    textHintLight: Color(0xFFE4E4E4),
    textHeading: Color(0xFF081F32),
    textDisable: Color(0xFFD4E2FA),
  );

  final Color text;
  final Color textLink;
  final Color textGray;
  final Color textDark;
  final Color textHint;
  final Color textHintLight;
  final Color textHeading;
  final Color textDisable;

  @override
  AppThemeTextColorExtension copyWith({Color? brandColor, Color? danger}) {
    return AppThemeTextColorExtension(
      text: brandColor ?? text,
      textLink: brandColor ?? textLink,
      textGray: brandColor ?? textGray,
      textDark: brandColor ?? textDark,
      textHint: brandColor ?? textHint,
      textHintLight: brandColor ?? textHintLight,
      textHeading: brandColor ?? textHeading,
      textDisable: brandColor ?? textDisable,
    );
  }

  @override
  AppThemeTextColorExtension lerp(ThemeExtension<AppThemeTextColorExtension>? other, double t) {
    if (other is! AppThemeTextColorExtension) {
      return this;
    }
    return AppThemeTextColorExtension(
      text: Color.lerp(text, other.text, t) ?? text,
      textLink: Color.lerp(textLink, other.textLink, t) ?? textLink,
      textGray: Color.lerp(textGray, other.textGray, t) ?? textGray,
      textDark: Color.lerp(textDark, other.textDark, t) ?? textDark,
      textHint: Color.lerp(textHint, other.textHint, t) ?? textHint,
      textHintLight: Color.lerp(textHintLight, other.textHintLight, t) ?? textHintLight,
      textHeading: Color.lerp(textHeading, other.textHeading, t) ?? textHeading,
      textDisable: Color.lerp(textDisable, other.textDisable, t) ?? textDisable,
    );
  }

  factory AppThemeTextColorExtension.of(BuildContext context) {
    return Theme.of(context).extension as AppThemeTextColorExtension;
  }

  factory AppThemeTextColorExtension.form(bool isDark) {
    return isDark ? AppThemeTextColorExtension.dark : AppThemeTextColorExtension.light;
  }
}
