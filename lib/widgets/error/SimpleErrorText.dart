import 'package:kyo_base/imports/base_component_import.dart';

class SimpleErrorText extends StatelessWidget {
  const SimpleErrorText({Key? key, required this.errorMsg}) : super(key: key);

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return errorMsg.text.make().objectCenter();
  }
}

