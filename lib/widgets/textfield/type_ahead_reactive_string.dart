import 'package:kyo_base/imports/base_component_import.dart';
import 'package:reactive_flutter_typeahead/reactive_flutter_typeahead.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TypeAheadStringReactive extends StatefulWidget {
  const TypeAheadStringReactive({
    Key? key,
    this.formControlName,
    required this.suggestionsCallback,
    this.hideOnLoading,
    this.hintText,
    this.showDropDown = false,
    this.onSuggestionSelected,
    this.scrollPadding,
    this.direction,
    this.showErrors,
  }) : super(key: key);

  final String? formControlName;
  final String? hintText;
  final SuggestionsCallback<String> suggestionsCallback;
  final bool? hideOnLoading;
  final bool? showDropDown;
  final SuggestionSelectionCallback<String>? onSuggestionSelected;
  final EdgeInsets? scrollPadding;
  final AxisDirection? direction;
  final ShowErrorsFunction? showErrors;

  @override
  State<TypeAheadStringReactive> createState() =>
      _TypeAheadStringReactiveState();
}

class _TypeAheadStringReactiveState extends State<TypeAheadStringReactive> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    callOnBuild(() {
      controller.text = formControl(context)?.value ?? '';
    });
    super.initState();
  }

  FormControl<String>? formControl(BuildContext context) {
    return (ReactiveForm.of(context)?.findControl(widget.formControlName!)
        as FormControl<String>?);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTypeAhead<String, String>(
      formControlName: widget.formControlName,
      stringify: (_) => _,
      direction: widget.direction ?? AxisDirection.up,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
        onChanged: (value) {
          TextSelection previousSelection = controller.selection;
          formControl(context)?.value = value;
          controller.selection = previousSelection;
        },
        autofocus: false,
        decoration: AppTextField.primaryStyle(context,
            inputStyleProps: InputStyleProps(
              hintText: widget.hintText,
              suffixIcon: widget.showDropDown == true
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      size: Dimens.ic,
                    ).pRight8()
                  : null,
            )),
      ),
      hideOnLoading: widget.hideOnLoading ?? true,
      // getImmediateSuggestions: true,
      animationDuration: Duration.zero,
      suggestionsCallback: widget.suggestionsCallback,
      noItemsFoundBuilder: (_) => Gaps.empty,
      errorBuilder: (_,error) {
        logger.e(error);
        return Gaps.empty;
      },
      onSuggestionSelected: widget.onSuggestionSelected,
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      showErrors: widget.showErrors ?? (control) => false,
    );
  }
}
