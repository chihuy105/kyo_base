import 'package:kyo_base/imports/base_component_import.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils{

  PermissionUtils._();

  static Future<bool> requestCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      return await Permission.camera.request().isGranted;
    }

    return Future.value(true);
  }

  static Future<bool> requestCurLocation() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      return await Permission.locationWhenInUse.request().isGranted;
    }

    return Future.value(true);
  }

  static Future<bool> requestStorage() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      return await Permission.storage.request().isGranted;
    }

    return Future.value(true);
  }
}
