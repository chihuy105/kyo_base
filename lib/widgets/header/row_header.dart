import 'package:kyo_base/imports/base_component_import.dart';

class RowHeader extends StatelessWidget {
  RowHeader({
    required this.title,
    this.onTap,
    this.allCaps = false,
    this.action = 'LBL_SEE_MORE',
    Key? key,
  });

  final String? title;
  final GestureTapCallback? onTap;
  final bool allCaps;
  final String action;

  @override
  Widget build(BuildContext context) {
    final titleStr = allCaps ? title!.capitalize : title;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: titleStr?.text
                      .subtitle1(context)
                      .xl
                      .letterSpacing(0.4)
                      .semiBold
                      .maxLines(2)
                      .ellipsis
                      .make()
                      .pOnly(right: Dimens.pad_XS) ??
                  Gaps.empty),
          GestureDetector(
              onTap: onTap,
              child: action.tr.text.base.colorPrimary(context).make())
        ],
      ),
    );
  }
}
