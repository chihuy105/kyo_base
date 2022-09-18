import 'package:kyo_base/imports/base_component_import.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum RadioBtnType { dot, rec }

class RadioBtnReactive<T> extends StatelessWidget {
  const RadioBtnReactive(
      {Key? key,
      this.formControl,
      this.formControlName,
      this.label,
      required this.value,
      this.showBorder = true,
      this.type = RadioBtnType.dot,
      this.inActiveBorderColor})
      : super(key: key);

  final String? label;
  final bool showBorder;
  final Color? inActiveBorderColor;
  final T value;
  final RadioBtnType type;

  // Set the control - use formControl
  final FormControl<T>? formControl;

  // or
  final String? formControlName;

  @override
  Widget build(BuildContext context) {
    final _formControl = formControl ??
        (ReactiveForm.of(context)?.findControl(formControlName!)
            as FormControl<T>?);

    return GestureDetector(
      onTap: () {
        _formControl?.updateValue(value);
      },
      child: ReactiveStatusListenableBuilder(
          formControl: _formControl,
          builder: (context, control, child) {
            bool isActive = control.value == value ? true : false;
            return Container(
              decoration: _getBorder(context, isActive),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  type == RadioBtnType.dot
                      ? ReactiveRadio<T>(
                          formControl: _formControl,
                          value: value,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        )
                      : SizedBox(
                          width: showBorder ? 14 : 6,
                        ),
                  label?.text
                          .color(
                            isActive
                                ? context.theme.primaryColor
                                : context.textTheme.bodyText2!.color!,
                          )
                          .make() ??
                      Gaps.empty,
                ],
              ).pOnly(right: showBorder ? 14 : 6),
            );
          }),
    );
  }

  _getBorder(BuildContext context, bool isActive) {
    Color borderColor;
    if (isActive) {
      borderColor = type == RadioBtnType.dot
          ? context.theme.primaryColor
          : context.themeColor.primaryLightest;
    } else {
      borderColor = showBorder
          ? (inActiveBorderColor ?? context.theme.dividerColor)
          : Colors.transparent;
    }

    return showBorder
        ? BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            color: isActive && type == RadioBtnType.rec
                ? context.themeColor.primaryLightest
                : Colors.transparent,
            borderRadius: BorderRadius.circular(Dimens.rad_XS),
          )
        : null;
  }
}
