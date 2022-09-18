import 'package:kyo_base/imports/base_component_import.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      this.src, {
        Key? key,
        this.height = 50,
        this.fit = BoxFit.fitWidth,
        this.background,
        this.showShadow = false,
        this.showBorder = true,
      }) : super(key: key);

  final String? src;
  final BoxFit fit;
  final double height;
  final Color? background;
  final bool showShadow;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    Widget img;
    if (src.isNullOrEmpty()) {
      img = AppIcon.userAvatar(size: height);
    } else {
      img = Img(
        src,
        fit: fit,
      );
    }

    final color = background ?? Colors.transparent;
    final BoxDecoration boxDecoration;
    if (showShadow) {
      boxDecoration = AppDecor.cardBoxShadow(
        context,
        color: color,
        shape: BoxShape.circle,
      );
    } else if (showBorder) {
      boxDecoration = AppDecor.cardGrayBorder(
        context,
        color: color,
        shape: BoxShape.circle,
      );
    } else {
      boxDecoration = BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      );
    }

    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: boxDecoration,
          clipBehavior: Clip.hardEdge,
          child: img.cornerRadius(Dimens.rad_max),
        ),
      ),
    );
  }
}
