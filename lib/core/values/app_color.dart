import 'package:kyo_base/imports/base_component_import.dart';

///
/// Color generator: https://material-foundation.github.io/material-theme-builder/#/custom
///
class AppColor {
  AppColor._();

  //// *** Primary *** ////

  static const AppColorData primary = AppColorData(
      light: Color(0xFF08B8C5),
      dark: Color(0xFF08B8C5)
  );

  static const AppColorData onPrimary = AppColorData(
      light: Color(0xFFffffff),
      dark: Color(0xff003545)
  );

  static const AppColorData primaryContainer = AppColorData(
      light: Color(0xFFb7eaff),
      dark: Color(0xff004d62)
  );

  static const AppColorData onPrimaryContainer = AppColorData(
      light: Color(0xFF001f2a),
      dark: Color(0xffb7eaff)
  );

  //// *** Secondary *** ////

  static const AppColorData secondary = AppColorData(
      light: Color(0xFF4c616b),
      dark: Color(0xffb3cad5)
  );

  static const AppColorData onSecondary = AppColorData(
      light: Color(0xFFffffff),
      dark: Color(0xff1e333c)
  );

  static const AppColorData secondaryContainer = AppColorData(
      light: Color(0xFFcfe6f1),
      dark: Color(0xff354a53)
  );

  static const AppColorData onSecondaryContainer = AppColorData(
      light: Color(0xFF071e26),
      dark: Color(0xffcfe6f1)
  );

  //// *** Tertiary *** ////

  static const AppColorData tertiary = AppColorData(
      light: Color(0xFF5b5b7e),
      dark: Color(0xffc4c3ea)
  );

  static const AppColorData onTertiary = AppColorData(
      light: Color(0xFFffffff),
      dark: Color(0xff2d2d4d)
  );

  static const AppColorData tertiaryContainer = AppColorData(
      light: Color(0xFFe1dfff),
      dark: Color(0xff444465)
  );

  static const AppColorData onTertiaryContainer = AppColorData(
      light: Color(0xFF181837),
      dark: Color(0xffe1dfff)
  );

  //// *** Error *** ////

  static const AppColorData red = AppColorData(
      light: Color(0xffDB4437),
      dark: Color(0xffDB4437)
  );

  static const AppColorData redAlert = AppColorData(
      light: Color(0xffF33131),
      dark: Color(0xffF33131)
  );

  static const AppColorData green = AppColorData(
      light: Color(0xff0F9D58),
      dark: Color(0xff0F9D58)
  );

  static const AppColorData error = AppColorData(
      light: Color(0xFFCB2222),
      dark: Color(0xFFCB2222)
  );

  static const AppColorData onError = AppColorData(
      light: Color(0xFFffffff),
      dark: Color(0xff680003)
  );

  static const AppColorData errorContainer = AppColorData(
      light: Color(0xFFffdad4),
      dark: Color(0xff930006)
  );

  static const AppColorData onErrorContainer = AppColorData(
      light: Color(0xFF410001),
      dark: Color(0xffffdad4)
  );

  static const AppColorData delete = AppColorData(
      light: Color(0xFFCB2222),
      dark: Color(0xFFCB2222)
  );

  //// *** Background *** ////

  static const AppColorData background = AppColorData(
      light: Color(0xFFF8F8F8),
      dark: Color(0xff191c1e)
  );

  static const AppColorData grayBackground = AppColorData(
      light: Color(0xFFF2F2F2),
      dark: Color(0xff272b2d)
  );

  static const AppColorData onBackground = AppColorData(
      light: Color(0xFF191c1e),
      dark: Color(0xffe1e3e5)
  );

  // Ex: card background,
  static const AppColorData surface = AppColorData(
      light: Color(0xffffffff),
      dark: Color(0xff191c1e)
  );

  static const AppColorData onSurface = AppColorData(
      light: Color(0xFF191c1e),
      dark: Color(0xffe1e3e5)
  );

  static const AppColorData outline = AppColorData(
      light: Color(0xFF70787d),
      dark: Color(0xff8a9296)
  );

  static const AppColorData surfaceVariant = AppColorData(
      light: Color(0xFFdce4e8),
      dark: Color(0xff40484c)
  );

  static const AppColorData onSurfaceVariant = AppColorData(
      light: Color(0xFF40484c),
      dark: Color(0xffc0c8cc)
  );

  static const AppColorData actionColor = primary;


  static const AppColorData sharedLink = AppColorData(
      light: Color(0xFF4A9B60),
      dark: Color(0xFF4A9B60)
  );

  //// *** TEXT Color *** ////

  static const AppColorData text = AppColorData(
      light: Color(0xFF242424),
      dark: Color(0xFFFAFBFC));

  static const AppColorData textLink = AppColorData(
      light: Color(0xFF5587EA),
      dark: Color(0xFF5587EA));

  static const AppColorData textGray = AppColorData(light: Color(0xFF444444), dark: Color(0xFF666666));

  static const AppColorData textHint = AppColorData(light: Color(0xFF9B9B9B), dark: Color(0xFF989898));

  static const AppColorData textHintLight = AppColorData(light: Color(0xFFE4E4E4), dark: Color(0xFFE4E4E4));

  static const AppColorData textHeading = AppColorData(light: Color(0xFF081F32), dark: Color(0xFF666666));

  static const AppColorData textDisable = AppColorData(light: Color(0xFFD4E2FA), dark: Color(0xFFCEDBF2));

  //// *** Current Project Color *** ////

  //// ******   Dynamic Colors   ****** ////

  static const Color loginGradientStart = Color(0xFFfbab66);
  static const Color loginGradientEnd = Color(0xFFf7418c);

  static MaterialColor get materialWhite =>
      const MaterialColor(
        0xFFFFFFFF,
        <int, Color>{
          50: Color(0xFFFFFFFF),
          100: Color(0xFFFFFFFF),
          200: Color(0xFFFFFFFF),
          300: Color(0xFFFFFFFF),
          400: Color(0xFFFFFFFF),
          500: Color(0xFFFFFFFF),
          600: Color(0xFFFFFFFF),
          700: Color(0xFFFFFFFF),
          800: Color(0xFFFFFFFF),
          900: Color(0xFFFFFFFF),
        },
      );

  static getTransparentGrey() {
    return Colors.grey[600]!.withOpacity(0.3);
  }
}

class AppColorData {
  final Color light;
  final Color dark;

  const AppColorData({required this.light, required this.dark});

  Color get dynamic => Get.isDarkMode ? dark : light;

  Color form(isDark) => isDark ? dark : light;
}


