import 'package:kyo_base/imports/base_component_import.dart';
import 'package:reactive_flutter_typeahead/reactive_flutter_typeahead.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TypeAheadReactive<D, V> extends StatelessWidget {
  TypeAheadReactive(
      {Key? key,
      this.formControlName,
      required this.suggestionsCallback,
      this.hideOnLoading,
      this.hintText,
      this.showDropDown = false,
      this.onSuggestionSelected,
      this.stringify,
      this.onChanged,
      this.debounceDuration = const Duration(milliseconds: 300),
      TextEditingController? controller,
      this.itemBuilder})
      : super(key: key) {
    _controller = controller ?? TextEditingController();
  }

  final String? formControlName;
  final String? hintText;
  final SuggestionsCallback<V> suggestionsCallback;
  final bool? hideOnLoading;
  final bool? showDropDown;
  final SuggestionSelectionCallback<V>? onSuggestionSelected;
  final ItemBuilder<V>? itemBuilder;

  final String Function(V value)? stringify;
  late final TextEditingController? _controller;
  final ValueChanged<String>? onChanged;

  final Duration debounceDuration;

  @override
  Widget build(BuildContext context) {
    return ReactiveTypeAhead<D, V>(
      formControlName: formControlName,
      debounceDuration: debounceDuration,
      stringify: stringify ?? (_) => _.toString(),
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        onChanged: onChanged,
        autofocus: false,
        decoration: AppTextField.primaryStyle(context,
            inputStyleProps: InputStyleProps(
              hintText: hintText,
              suffixIcon: showDropDown == true
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      size: Dimens.ic,
                    ).pRight8()
                  : null,
            )),
      ),
      hideOnLoading: hideOnLoading ?? true,
      // getImmediateSuggestions: true,
      animationDuration: Duration.zero,
      suggestionsCallback: suggestionsCallback,
      noItemsFoundBuilder: (_) => Gaps.empty,
      onSuggestionSelected: (item) {
        _controller?.text = stringify?.call(item) ?? item.toString();
        (ReactiveForm.of(context)?.findControl(formControlName!)
                as FormControl<V>?)
            ?.value = item;
        onSuggestionSelected?.call(item);
      },
      itemBuilder: itemBuilder ??
          (context, suggestion) {
            return ListTile(
              title: Text(stringify?.call(suggestion) ?? suggestion.toString()),
            );
          },
    );
  }
}
