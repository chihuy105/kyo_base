import 'package:kyo_base/imports/base_component_import.dart';

Future<void> callOnBuildDelay(Function func, {Duration delay = const Duration(milliseconds: 300)}) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(delay).then((value) => func());
  });
}

Future<void> callOnBuild(Function func) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    func();
  });
}

class AppUtils {
  AppUtils._();

  static Future<String?> getDeviceID() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
    return null;
  }

  static Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  static Future<String> get appName async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.appName;
  }

  static Future<String> get packageName async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.packageName;
  }

  static Future<String> get version async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.version;
  }

  static Future<String> get buildNumber async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.buildNumber;
  }

  static void dismissKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
