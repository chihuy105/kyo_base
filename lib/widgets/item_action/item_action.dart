import 'package:kyo_base/imports/base_component_import.dart';

class ItemAction extends _ItemAction {
  const ItemAction(
      {Key? key,
      String? count,
      required Widget icon,
      VoidCallback? onPressed,
      bool? hideCountOnNull})
      : super(
          key: key,
          count: count,
          icon: icon,
          onPressed: onPressed,
          hideCountOnNull: hideCountOnNull ?? false,
        );

  factory ItemAction.like({
    required String? count,
    VoidCallback? onPressed,
    double iconSize = Dimens.ic_S,
    Color? iconColor,
    bool? isLiked,
  }) {
    return ItemAction(
        count: count,
        hideCountOnNull: true,
        icon: isLiked == true
            ? Assets.icons.likedThumb.svg(
                height: iconSize,
                width: iconSize,
                color: iconColor,
              )
            : Assets.icons.likeThumb.svg(
                height: iconSize,
                width: iconSize,
                color: iconColor,
              ),
        onPressed: onPressed);
  }

  factory ItemAction.comment({
    required String? count,
    VoidCallback? onPressed,
    double iconSize = Dimens.ic_S,
    Color? iconColor,
  }) {
    return ItemAction(
      count: count,
      hideCountOnNull: true,
      icon: Icon(
        Icons.messenger_outline_rounded,
        size: iconSize,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }
}

class _ItemAction extends StatelessWidget {
  const _ItemAction(
      {Key? key,
      this.count,
      required this.icon,
      this.onPressed,
      this.hideCountOnNull = false})
      : super(key: key);

  final String? count;
  final bool hideCountOnNull;
  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (count.isNullOrEmpty()) return Gaps.empty;

    return Btn(
      btnType: BtnType.TEXT,
      padding: Dimens.edge_zero,
      onPressed: onPressed,
      child: Row(
        children: [
          icon,
          (hideCountOnNull && count == '0' ? ' ' : count)
              .toString()
              .text
              .caption(context)
              .make()
              .pLeft4()
        ],
      ),
    ).pRight12();
  }
}
