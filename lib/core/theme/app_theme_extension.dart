import 'package:kyo_base/imports/base_component_import.dart';

extension AppThemeContextExtend on BuildContext {
  AppThemeExtension get themeColor =>
      Theme.of(this).extension<AppThemeExtension>() ?? AppThemeExtension.light;
}

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.n6,
    required this.n8,
    required this.primaryDark,
    required this.primaryLightest,
    required this.n3,
    required this.gray5,
    required this.gray6,
    required this.gray,
    required this.darkerGray,
    required this.link,
    required this.divider,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
  });

  static const AppThemeExtension dark = AppThemeExtension(
    n6: Color(0xFFA5ABB3),
    n8: Color(0xFFEBEEF2),
    primaryDark: Color(0xFF0399A3),
    primaryLightest: Color(0xFFE5FFFF),
    n3: Color(0xFF545D69),
    gray5: Color(0xFF8C8C8C),
    gray6: Color(0xFFF2F2F2),
    gray: Color(0xFF444444),
    darkerGray: Color(0xFFE1E1E1),
    link: Color(0xFF5587EA),
    divider: Color(0x1f191c1e),
    success: Color(0xFF00B865),
    error: Color(0xFFD50000),
    warning: Color(0xFFFFC400),
    info: Color(0xFF5587EA),
  );

  static const AppThemeExtension light = AppThemeExtension(
    n6: Color(0xFFA5ABB3),
    n8: Color(0xFFEBEEF2),
    primaryDark: Color(0xFF0399A3),
    primaryLightest: Color(0xFFE5FFFF),
    n3: Color(0xFF545D69),
    gray5: Color(0xFF8C8C8C),
    gray6: Color(0xFFF2F2F2),
    gray: Color(0xFF444444),
    darkerGray: Color(0xFFE1E1E1),
    link: Color(0xFF5587EA),
    divider: Color(0x1f191c1e),
    success: Color(0xFF00B865),
    error: Color(0xFFD50000),
    warning: Color(0xFFFFC400),
    info: Color(0xFF5587EA),
  );

  final Color n3;
  final Color n6;
  final Color n8;
  final Color primaryDark;
  final Color primaryLightest;
  final Color gray5;
  final Color gray6;
  final Color gray;
  final Color darkerGray;
  final Color link;
  final Color divider;
  final Color success;
  final Color error;
  final Color warning;
  final Color info;

  @override
  AppThemeExtension copyWith({Color? brandColor, Color? danger}) {
    return AppThemeExtension(
      n6: n6,
      n8: n8,
      primaryDark: primaryDark,
      primaryLightest: primaryLightest,
      n3: n3,
      gray5: gray5,
      gray6: gray6,
      gray: gray,
      darkerGray: darkerGray,
      link: link,
      divider: divider,
      success: success,
      error: error,
      warning: warning,
      info: info,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      n6: Color.lerp(n6, other.n6, t) ?? n6,
      n8: Color.lerp(n8, other.n8, t) ?? n8,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t) ?? primaryDark,
      primaryLightest: Color.lerp(primaryLightest, other.primaryLightest, t) ??
          primaryLightest,
      n3: Color.lerp(n3, other.n3, t) ?? n3,
      gray5: Color.lerp(gray5, other.gray5, t) ?? gray5,
      gray6: Color.lerp(gray6, other.gray6, t) ?? gray6,
      gray: Color.lerp(gray, other.gray, t) ?? gray,
      darkerGray: Color.lerp(darkerGray, other.darkerGray, t) ?? darkerGray,
      link: Color.lerp(link, other.link, t) ?? link,
      divider: Color.lerp(divider, other.divider, t) ?? divider,
      success: Color.lerp(success, other.success, t) ?? success,
      error: Color.lerp(error, other.error, t) ?? error,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      info: Color.lerp(info, other.info, t) ?? info,
    );
  }

  factory AppThemeExtension.of(BuildContext context) {
    return Theme.of(context).extension as AppThemeExtension;
  }

  factory AppThemeExtension.form(bool isDark) {
    return isDark ? AppThemeExtension.dark : AppThemeExtension.light;
  }

  static ColorScheme colorSchemaFrom({required bool isDark}) {
    return isDark ? _colorSchemeDark : _colorScheme;
  }
}

const ColorScheme _colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF08B8C5),
  onPrimary: Color(0xFFffffff),
  primaryContainer: Color(0xFFb7eaff),
  onPrimaryContainer: Color(0xFF001f2a),
  secondary: Color(0xFF4c616b),
  onSecondary: Color(0xFFffffff),
  secondaryContainer: Color(0xFFcfe6f1),
  onSecondaryContainer: Color(0xFF071e26),
  tertiary: Color(0xFF5b5b7e),
  onTertiary: Color(0xFFffffff),
  tertiaryContainer: Color(0xFFe1dfff),
  onTertiaryContainer: Color(0xFF181837),
  error: Color(0xFFCB2222),
  onError: Color(0xFFffffff),
  errorContainer: Color(0xFFffdad4),
  onErrorContainer: Color(0xFF410001),
  background: Color(0xFFF8F8F8),
  onBackground: Color(0xFF191c1e),
  surface: Color(0xffffffff),
  onSurface: Color(0xFF191c1e),
  outline: Color(0xFF70787d),
  surfaceVariant: Color(0xFFdce4e8),
  onSurfaceVariant: Color(0xFF40484c),
);

const ColorScheme _colorSchemeDark = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF08B8C5),
  onPrimary: Color(0xFFffffff),
  primaryContainer: Color(0xFFb7eaff),
  onPrimaryContainer: Color(0xFF001f2a),
  secondary: Color(0xFF4c616b),
  onSecondary: Color(0xFFffffff),
  secondaryContainer: Color(0xFFcfe6f1),
  onSecondaryContainer: Color(0xFF071e26),
  tertiary: Color(0xFF5b5b7e),
  onTertiary: Color(0xFFffffff),
  tertiaryContainer: Color(0xFFe1dfff),
  onTertiaryContainer: Color(0xFF181837),
  error: Color(0xFFCB2222),
  onError: Color(0xFFffffff),
  errorContainer: Color(0xFFffdad4),
  onErrorContainer: Color(0xFF410001),
  background: Color(0xFFF8F8F8),
  onBackground: Color(0xFF191c1e),
  surface: Color(0xffffffff),
  onSurface: Color(0xFF191c1e),
  outline: Color(0xFF70787d),
  surfaceVariant: Color(0xFFdce4e8),
  onSurfaceVariant: Color(0xFF40484c),
);
