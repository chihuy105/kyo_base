import 'package:kyo_base/imports/base_component_import.dart';

class BtnCircle extends StatelessWidget {
  const BtnCircle({Key? key, required this.child, this.onPressed}) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Btn(
      btnType: BtnType.TEXT,
      child: child,
      onPressed: onPressed,
    );
  }
}

