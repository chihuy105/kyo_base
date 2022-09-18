import 'package:kyo_base/imports/base_component_import.dart';

class LocalDataService {

  LocalDataService({required this.boxKey});

  static Box? appHiveBox;
  final String boxKey;

  Future<void> createBox() async {
    appHiveBox = await Hive.openBox(boxKey);
  }

  deleteFromLocal(String key) async {
    appHiveBox?.delete(key);
  }
}
