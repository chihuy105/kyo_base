import 'package:kyo_base/imports/base_component_import.dart';

class AppIcon {
  AppIcon._();

  static Widget commentIcon({double? size, Color? color}) => Icon(
    Icons.messenger_outline_rounded,
    size: size,
    color: color,
  );

  static Widget shareIcon({double? size, Color? color}) => Assets.icons.exitUp.svg(
    color: color,
    height: size,
    width: size,
  );

  static Widget userAvatar({double? size, Color? color}) => Icon(
    FontAwesomeIcons.solidCircleUser,
    color: color,
    size: size,
  );

  // static Widget userAvatar({double? size, Color? color}) => Assets.icons.avatarFill.svg(
  //   color: color ?? AppColor.textGray.dynamic,
  //   width: size,
  //   height: size,
  // );

}
