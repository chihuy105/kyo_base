import 'package:kyo_base/imports/base_component_import.dart';

class BtnMoreArrow extends StatelessWidget {
  const BtnMoreArrow({Key? key, this.onPressed, required this.isMore, this.padding}) : super(key: key);

  final VoidCallback? onPressed;
  final bool isMore;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Btn(
      btnType: BtnType.TEXT,
      padding: padding ?? Dimens.edge_zero,
      child: isMore
          ? const Icon(Icons.keyboard_arrow_up)
          : const Icon(Icons.keyboard_arrow_down),
      onPressed: onPressed,
    );
  }
}
