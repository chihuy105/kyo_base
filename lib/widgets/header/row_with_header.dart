import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/widgets/header/row_header.dart';

class RowWithHeader extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final bool allCaps;
  final double px;
  final Widget child;
  final String action;

  const RowWithHeader({
    required this.title,
    this.onTap,
    this.allCaps = false,
    Key? key,
    this.px = 16,
    this.action = 'LBL_SEE_MORE',
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStr = allCaps ? title.capitalize : title;
    return Container(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          RowHeader(
            title: titleStr,
            onTap: onTap,
            action: action,
          ).marginOnly(top: Dimens.pad_L, bottom: Dimens.pad_S),
          child
        ],
      ).px(px),
    );
  }
}
