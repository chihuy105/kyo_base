import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/imports/widget_import.dart';
import 'package:flutter/cupertino.dart';

class LikeCount extends StatelessWidget {
  const LikeCount({Key? key, required this.count, this.iconSize = Dimens.ic_S})
      : super(key: key);

  final String? count;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    if (count.isNullOrEmpty()) return Gaps.empty;

    return Btn(
      btnType: BtnType.TEXT,
      padding: Dimens.edge_zero,
      child: Row(
        children: [
          Assets.icons.likeThumb.svg(height: iconSize, width: iconSize),
          Gaps.hGap4,
          count.toString().text.colorHint(context).make()
        ],
      ),
      onPressed: () {},
    );
  }
}
