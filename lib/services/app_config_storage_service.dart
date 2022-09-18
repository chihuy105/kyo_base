import 'package:kyo_base/data/app/app_config_model.dart';
import 'package:kyo_base/imports/base_component_import.dart';

class AppConfigStorage {

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) {
      return;
    }
    _box = await Hive.openBox(
      'appStorage',
    );
    _isInitialized = true;

    appConfig.openCount = appConfig.openCount + 1;
    save();
  }

  late Box _box;
  final appConfigKey = 'appConfig';
  AppConfigModel? _appConfig;

  Future<void> clear() async {
    await _box.put(appConfigKey, null);
  }

  Future<void> save() async {
    await _box.put(
      appConfigKey,
      _appConfig,
    );
  }

  Future<void> setAppConfigModel(AppConfigModel data) async {
    _appConfig = data;
    await _box.put(
      appConfigKey,
      data,
    );
  }

  AppConfigModel get appConfig {
    if (_appConfig != null) {
      return _appConfig!;
    }
    _appConfig = _box.get(appConfigKey, defaultValue: AppConfigModel()) as AppConfigModel;
    return _appConfig!;
  }

  bool isFirstRun() {
    return appConfig.openCount == 1;
    // return true;
  }

}
