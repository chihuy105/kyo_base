import 'package:kyo_base/imports/base_component_import.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppReactiveDropDown<T> extends StatelessWidget {
  const AppReactiveDropDown(
      {Key? key,
      this.formControlName,
      required this.items,
      this.formControl,
      this.inputStyleProps})
      : super(key: key);

  final String? formControlName;
  final FormControl<T>? formControl;
  final List<DropdownMenuItem<T>> items;
  final InputStyleProps? inputStyleProps;

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField<T>(
      key: key,
      formControl: formControl,
      formControlName: formControlName,
      items: items,
      elevation: 1,
      borderRadius: BorderRadius.circular(Dimens.rad_S),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: context.theme.primaryColor,
      ),
      decoration: AppTextField.primaryStyle(
        context,
        inputStyleProps: inputStyleProps ?? const InputStyleProps(),
      ),
    );
  }
}
