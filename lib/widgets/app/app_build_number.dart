import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/core/utils/app_utils.dart';

class AppBuildNumber extends StatefulWidget {
  const AppBuildNumber({Key? key}) : super(key: key);

  @override
  State<AppBuildNumber> createState() => _AppBuildNumberState();
}

class _AppBuildNumberState extends State<AppBuildNumber> {

  String buildNumber = '';

  @override
  void initState() {
    AppUtils.buildNumber.then((value) {
      setState(() {
        buildNumber = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return buildNumber.text.make();
  }
}

