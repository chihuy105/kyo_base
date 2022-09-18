import 'package:kyo_base/imports/base_component_import.dart';

class BaseSliverAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Data
  final Widget? title;
  final String? titleText;
  final Widget? leading;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;

  // Style
  final bool isSliver;
  final bool? centerTitle;
  final bool? snap;
  final bool? floating;
  final bool? pinned;
  final double? elevation;
  final double? titleSpacing;

  final Color? backgroundColor;
  final Color? titleColor;

  final int? titleMaxLine;

  const BaseSliverAppBar({
    Key? key,
    this.title,
    this.action,
    this.leading,
    this.centerTitle,
    this.snap,
    this.floating,
    this.pinned,
    this.elevation,
    this.bottom,
    this.titleText,
    this.isSliver = false,
    this.titleMaxLine,
    this.titleSpacing,
    this.backgroundColor,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleFinal = titleText != null
        ? titleText!.textAuto
            .textStyle(context.textTheme.titleSmall)
            .minFontSize(Dimens.text_mid_S)
            .maxLines(titleMaxLine ?? 1)
            .ellipsis
            .color(titleColor ?? context.theme.defaultTextColor())
            .make()
        : title;

    final bthBack = BtnBack.isShowBtnBack(context) ? const BtnBack() : null;

    if (isSliver) {
      return SliverAppBar(
        pinned: pinned ?? true,
        snap: snap ?? false,
        floating: floating ?? false,
        centerTitle: centerTitle ?? true,
        title: titleFinal,
        titleSpacing: titleSpacing,
        elevation: elevation ?? 1.0,
        leading: leading ?? bthBack,
        bottom: bottom,
        automaticallyImplyLeading: true,
        backgroundColor:
            backgroundColor ?? context.theme.colorScheme.background,
        actions: action ?? <Widget>[],
      );
    }

    return AppBar(
      centerTitle: centerTitle ?? true,
      title: titleFinal,
      elevation: elevation ?? 0,
      titleSpacing: titleSpacing,
      leading: leading ?? bthBack,
      bottom: bottom,
      automaticallyImplyLeading: true,
      backgroundColor: backgroundColor ?? context.theme.colorScheme.background,
      actions: action ?? <Widget>[],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
