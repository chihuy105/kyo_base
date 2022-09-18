import 'package:kyo_base/imports/base_component_import.dart';

class BtnCircleIcon extends StatelessWidget {
  const BtnCircleIcon(
    this.icon, {
    this.onPress,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.borderColor,
    this.borderSize = 2,
    this.size = Dimens.ic_XL2,
    this.style,
    this.padding,
    Key? key,
  }) : super(key: key);

  final dynamic icon;
  final VoidCallback? onPress;
  final Color? backgroundColor;
  final double? iconSize;
  final Color? iconColor;
  final Color? borderColor;
  final double? size;
  final double borderSize;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget;
    if (icon is IconData) {
      iconWidget = FittedBox(
        child: Icon(
          icon,
          size: iconSize ?? Dimens.ic_L,
          color: iconColor ?? Colors.white,
        ),
      );
    } else {
      iconWidget = icon;
    }

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey[600]!.withOpacity(0.3),
          shape: BoxShape.circle
      ),
      child: Btn(
        padding: padding ?? Dimens.edge_zero,
        btnType: BtnType.TEXT,
        onPressed: onPress ?? () {},
        child: iconWidget,
      ),
    );
  }
}
