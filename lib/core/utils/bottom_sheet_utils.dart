import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomSheetUtils {
  BottomSheetUtils._();

  static Future show({required BuildContext context, required Widget child, bool? enableDrag}) {
    return showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
      enableDrag: enableDrag ?? true,
    );
  }

  static void showCupertinoDatePicker({
    required BuildContext context,
    required ValueChanged<DateTime> onDateTimeChanged,
    DateTime? initialDateTime,
    int? minimumYear,
    int? maximumYear,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SizedBox(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              onDateTimeChanged: onDateTimeChanged,
              initialDateTime: initialDateTime ?? DateTime.now(),
              minimumYear: minimumYear ?? 1900,
              maximumYear: maximumYear,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
            ),
          );
        });
  }

  static void showCupertino(
      {required BuildContext context, required Widget child}) {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return child;
        });
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
