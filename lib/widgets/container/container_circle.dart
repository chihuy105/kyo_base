import 'package:kyo_base/imports/base_component_import.dart';

class ContainerCircle extends StatelessWidget {
  const ContainerCircle({Key? key, required this.color, required this.size, this.border}) : super(key: key);

  final Color color;
  final double size;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: border),
    );
  }
}
