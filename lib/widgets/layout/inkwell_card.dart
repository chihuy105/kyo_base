import 'package:kyo_base/imports/base_component_import.dart';

class InkWellCard extends StatelessWidget {
  const InkWellCard({Key? key, required this.child, this.onPressed})
      : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
