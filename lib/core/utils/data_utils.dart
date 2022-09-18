import 'dart:math';

import 'package:kyo_base/imports/base_component_import.dart';

class DataUtils{
  DataUtils._();

  static String generateTag() {
    DateTime dateTime = DateTime.now();
    String tag = Random().nextInt(1000).toString() +
        Random().nextInt(1000).toString() +
        dateTime.second.toString() +
        dateTime.millisecond.toString() +
        dateTime.microsecond.toString();
    return tag;
  }
}
