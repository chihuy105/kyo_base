import 'package:kyo_base/imports/base_component_import.dart';

class BtnCloseCircleWhite extends StatelessWidget {
  const BtnCloseCircleWhite({
    Key? key,
    this.size = Dimens.ic,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: BtnCircleIcon(
        Icons.close,
        backgroundColor: context.themeColor.gray5,
        iconColor: context.themeColorText.text,
        padding: Dimens.edge_XS3,
        onPress: (){
          context.router.pop();
        },
      ),
    );
  }
}

