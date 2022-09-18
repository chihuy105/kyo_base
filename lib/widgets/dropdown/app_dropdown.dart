import 'package:kyo_base/imports/base_component_import.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    Key? key,
    required this.items,
    this.inputStyleProps,
    this.onChanged, required this.value,
  }) : super(key: key);

  final List<DropdownMenuItem<T>> items;
  final InputStyleProps? inputStyleProps;
  final ValueChanged<T?>? onChanged;
  final T value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<T>(
          key: key,
          items: items,
          elevation: 1,
          value: value,
          borderRadius: BorderRadius.circular(Dimens.rad_S),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: context.theme.primaryColor,
          ).pRight8(),
          onChanged: onChanged,
          decoration: AppTextField.primaryStyle(
            context,
            inputStyleProps: inputStyleProps ?? const InputStyleProps(contentPadding: Dimens.edge_y_default),
          ),
        ),
      ),
    );
  }
}
