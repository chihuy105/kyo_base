import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/cupertino.dart';

class BtnBack extends StatelessWidget {
  final VoidCallback? onPress;
  final double size;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool? checkCanPop;
  final bool isCupertino;

  static bool isShowBtnBack(BuildContext context) => (ModalRoute.of(context)?.canPop ?? false) == true;

  const BtnBack(
      {Key? key,
      this.onPress,
      this.size = 25,
      this.iconColor,
      this.backgroundColor,
      this.checkCanPop = true,
      this.isCupertino = true})
      : super(key: key);

  static BtnBack transparent(BuildContext context) {
    return BtnBack(
      iconColor: Theme.of(context).canvasColor,
      backgroundColor: Colors.transparent,
    );
  }

  static BtnBack forHeader(BuildContext context, bool isTransparent) {
    final iconColor =
        isTransparent ? Colors.white : Theme.of(context).primaryColor;
    final iconBackground =
        isTransparent ? Colors.grey[600]!.withOpacity(0.3) : Colors.transparent;

    return BtnBack(
      iconColor: iconColor,
      backgroundColor: iconBackground,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (checkCanPop == true) {
      if (!isShowBtnBack(context)) {
        return Gaps.empty;
      }
    }

    if (isCupertino) {
      return CupertinoNavigationBarBackButton(
        onPressed: onPress ?? () => context.router.pop(),
        color: iconColor,
      );
    }

    final iconColorUse = iconColor ?? context.theme.iconTheme.color;
    final backgroundColorUse = backgroundColor ?? Colors.transparent;

    return BtnCircleIcon(
      Icon(
        CupertinoIcons.back,
        size: size,
        color: iconColorUse,
      ),
      onPress: onPress ?? () => context.router.pop(),
      backgroundColor: backgroundColorUse,
      iconColor: iconColorUse,
    );
  }
}
