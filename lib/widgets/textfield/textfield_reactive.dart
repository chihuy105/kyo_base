import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/widgets/button/actions/btn_clear.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TextFieldReactive<T> extends StatelessWidget {
  const TextFieldReactive({
    Key? key,
    this.formControlName,
    this.keyboardType,
    this.validationMessages,
    this.textInputAction,
    this.decoration,
    this.hintText,
    this.isOnlyRequired,
    this.showErrors,
    this.obscureText,
    this.inputFormatters,
    this.minLines,
    this.readOnly,
    this.readOnlyBackground,
    this.onTap,
    this.maxLines,
    this.formControl,
    this.inputStyleProps,
    this.showClear,
    this.textStyle,
    this.maxLength,
    this.hideCounter,
  }) : super(key: key);

  final FormControl<T>? formControl;
  final String? formControlName;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final ValidationMessagesFunction<T>? validationMessages;
  final TextInputAction? textInputAction;
  final InputDecoration? decoration;
  final ShowErrorsFunction? showErrors;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;
  final int? maxLines;
  final bool? readOnly;
  final bool? readOnlyBackground;
  final GestureTapCallback? onTap;
  final int? maxLength;

  // Customize
  final String? hintText;
  final bool? isOnlyRequired;
  final InputStyleProps? inputStyleProps;
  final bool? showClear;
  final bool? hideCounter;

  @override
  Widget build(BuildContext context) {
    ValidationMessagesFunction<T>? finalValidationMessages = validationMessages;
    if (isOnlyRequired == true) {
      finalValidationMessages = (control) => {
            ValidationMessage.required: 'fillRequired'.tr,
          };
    }
    InputStyleProps inputStylePropsFinal =
        (inputStyleProps ?? const InputStyleProps()).copyWith(
      hintText: hintText,
    );
    if (showClear == true) {
      inputStylePropsFinal =
          inputStylePropsFinal.copyWith(suffixIcon: _buildClearBtn(context));
    }
    if (readOnly == true && onTap == null) {
      inputStylePropsFinal = inputStylePropsFinal.copyWith(
        backgroundColor: context.themeColor.gray6,
      );
    }
    if (hideCounter == true) {
      inputStylePropsFinal = inputStylePropsFinal.copyWith(
        counter: Gaps.empty,
      );
    }

    return ReactiveTextField<T>(
      showErrors: showErrors ?? ((control) => false),
      style: textStyle,
      obscureText: obscureText ?? false,
      formControlName: formControlName,
      formControl: formControl,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLength: maxLength,
      validationMessages: finalValidationMessages,
      textInputAction: textInputAction ?? TextInputAction.next,
      minLines: minLines,
      maxLines: obscureText == true ? 1 : maxLines,
      readOnly: readOnly ?? false,
      onTap: onTap,
      decoration: decoration ??
          AppTextField.primaryStyle(
            context,
            inputStyleProps: inputStylePropsFinal,
          ),
    );
  }

  Widget _buildClearBtn(BuildContext context) {
    AbstractControl? formControlFinal;
    if (formControl != null) {
      formControlFinal = formControl;
    } else if (formControlName != null) {
      formControlFinal =
          ReactiveForm.of(context)?.findControl(formControlName!);
    }

    return BtnClear(
      onPressed: () => formControlFinal?.value = null,
    );
  }
}
