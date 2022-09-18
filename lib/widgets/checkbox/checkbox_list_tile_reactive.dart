import 'package:kyo_base/imports/base_component_import.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckboxListTileReactive extends StatelessWidget {
  const CheckboxListTileReactive({
    Key? key,
    this.label,
    this.formControlName,
    this.formControl,
    this.labelWidget,
    this.contentPadding,
    this.visualDensity,
    this.dense,
    this.enable = true,
  }) : super(key: key);

  final String? label;
  final Widget? labelWidget;
  final String? formControlName;
  final FormControl<bool>? formControl;
  final EdgeInsetsGeometry? contentPadding;
  final VisualDensity? visualDensity;
  final bool? dense;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return ReactiveCheckboxListTile(
      formControlName: formControlName,
      formControl: formControl,
      controlAffinity: ListTileControlAffinity.leading,
      title: labelWidget ?? label?.text.make(),
      contentPadding: contentPadding ?? Dimens.edge_x_XS,
      visualDensity: visualDensity,
      dense: dense,
    );
  }
}
