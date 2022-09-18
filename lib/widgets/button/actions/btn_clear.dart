import 'package:kyo_base/imports/base_component_import.dart';

class BtnClear extends StatelessWidget {
  const BtnClear({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BtnCircleIcon(
      Icons.clear,
      onPress: onPressed,
      backgroundColor: Colors.transparent,
      iconColor: context.theme.hintColor,
    ).px12();
  }
}

