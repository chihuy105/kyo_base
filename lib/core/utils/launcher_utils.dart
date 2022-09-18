import 'package:kyo_base/imports/base_component_import.dart';

class LauncherUtils{
  LauncherUtils._();

  static Future<bool> callNumber(BuildContext context, String phone) async{
    final Uri uri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (!await launchUrl(uri)) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  static Future<bool> showURL(BuildContext context, String url) async {
    var urlFinal = url;
    if(!urlFinal.contains('http')) {
      urlFinal = 'https://$urlFinal';
    }
    if (!await launchUrl(Uri.parse(urlFinal))) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  static Future<bool> emailTo({required String email}) async{
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (!await launchUrl(uri)) {
    return Future.value(false);
    }
    return Future.value(true);
  }
}
