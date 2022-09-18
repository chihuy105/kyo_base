import 'package:kyo_base/imports/base_component_import.dart';

class AppCheckBox extends StatelessWidget {
  AppCheckBox({Key? key, this.label, this.onChanged, this.initialValue})
      : super(key: key);

  final String? label;
  final bool? initialValue;
  late final isChecked = RxBool(initialValue ?? false);
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CheckboxListTile(
        value: isChecked.value,
        title: label?.text.make(),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) {
          isChecked.value = !isChecked.value;
          onChanged?.call(isChecked.value);
        },
      ),
    );
  }
}
