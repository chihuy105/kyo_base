import 'package:kyo_base/imports/base_component_import.dart';

enum TextFieldOutlineState { NORMAL, NOT_EMPTY, NOT_VALID }

class TextFieldOutline extends StatefulWidget {
  const TextFieldOutline({
    Key? key,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.autoFocus = false,
    this.iconData,
    this.radius = Dimens.rad_L,
    this.hintText,
    this.validator,
    this.onSaved,
    this.showClear = false,
    this.keyboardType,
    this.focusNode,
    this.borderWidth = 1,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
    this.labelText,
    this.colorOnFill = false,
    this.initialValue,
    this.onChanged,
    this.onChangedDelay,
    this.onFocusChange,
    this.backgroundColor,
    this.iconSize,
    this.controller,
    this.timerDuration = const Duration(seconds: 1),
    this.maxLines,
    this.minLines,
    this.iconPadding,
    this.hintStyle,
    this.showBorder = true,
    this.enabled,
    this.iconDataTail,
    this.helperText,
    this.maxLength,
    this.borderColor,
    this.suffix,
    this.clearBtnBuilder,
    this.textInputAction,
    this.showTopMaxLength = false,
    this.textStyle,
    this.labelStyle,
    this.showCounter = false,
    this.keepClearOnUnFocus,
    this.suffixMaxWidth,
  }) : super(key: key);

  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? initialValue;
  final Duration timerDuration;
  final bool? enabled;
  final bool? keepClearOnUnFocus;

  final TextEditingController? controller;

  // Event
  final ValueChanged<String>? onChangedDelay;
  final ValueChanged<String>? onChanged;
  final Function(bool hasFocus, String value)? onFocusChange;
  final FormFieldValidator<String>? validator;

  //this function call when formKey.currentState?.save() is invoked
  final FormFieldSetter<String>? onSaved;

  // Focus
  final bool autoFocus;
  final FocusNode? focusNode;

  // Style Data
  final Widget? suffix;
  final double? suffixMaxWidth;
  final Widget Function(TextEditingController controller, bool showCLear)?
      clearBtnBuilder;
  final bool colorOnFill;
  final TextInputType? keyboardType;
  final bool showClear;
  final int? maxLines;
  final int? minLines;
  final IconData? iconData;
  final IconData? iconDataTail;
  final EdgeInsetsGeometry? iconPadding;
  final TextInputAction? textInputAction;

  // Max Length
  final int? maxLength;
  final bool showTopMaxLength;
  final bool showCounter;

  // Style
  final double? iconSize;
  final double radius;
  final double borderWidth;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final bool showBorder;
  final VoidCallback? onEditingComplete;
  final void Function(TextEditingController controller, String value)?
      onFieldSubmitted;

  @override
  _TextFieldOutlineState createState() => _TextFieldOutlineState();
}

class _TextFieldOutlineState extends State<TextFieldOutline> {
  // TextFieldOutlineState _state = TextFieldOutlineState.NORMAL;

  bool _showingClearBtn = false;

  late FocusNode _focusNode;
  late TextEditingController _controller;
  final _fieldKey = GlobalKey<FormFieldState>();

  // Length count
  final lengthCountLD = 0.obs;

  // Timer for onChange
  Timer? _timer;

  @override
  void initState() {
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextFieldOutline oldWidget) {
    if (widget.initialValue != null &&
        _controller.text.isNullOrEmpty() == true) {
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onTextChange() {
    widget.onChanged?.call(_controller.text);

    // Hide/Show clear button when text null or not null
    if (widget.showClear) {
      setState(() {
        _showingClearBtn = _willShowClearBtn();
      });
    }

    // Assign callback text change event
    if (widget.onChangedDelay != null) {
      _textChangedWithTimer(_controller.text);
    }

    if (widget.showTopMaxLength) {
      lengthCountLD.value = _controller.text.length;
    }
  }

  void _textChangedWithTimer(String val) {
    _timer?.cancel();
    _timer = Timer(widget.timerDuration, () {
      widget.onChangedDelay!(_controller.text);
    });
  }

  void _onFocusChange() {
    // _validateEmpty();

    // Assign callback focus event
    if (widget.onFocusChange != null) {
      widget.onFocusChange!(_focusNode.hasFocus, _controller.text);
    }
    // Validate on lost focus
    if (widget.validator != null) {
      if (!_focusNode.hasFocus) {
        _fieldKey.currentState?.validate();
      }
    }
    // Hide/Show clear on focus change
    if (widget.showClear) {
      setState(() {
        _showingClearBtn = _willShowClearBtn();
      });
    }
  }

  bool _willShowClearBtn() {
    return !(!widget.showClear ||
        (_controller.text.isNullOrEmpty()) ||
        !(_focusNode.hasFocus || widget.keepClearOnUnFocus == true));
  }

  // void _validateEmpty() {
  //   if (_state == TextFieldOutlineState.NOT_VALID) return;
  //
  //   if (_focusNode.hasFocus && _state != TextFieldOutlineState.NOT_EMPTY) {
  //     _state = TextFieldOutlineState.NOT_EMPTY;
  //   } else if (!_focusNode.hasFocus &&
  //       (_controller.text.isNullOrEmpty())) {
  //     _state = TextFieldOutlineState.NORMAL;
  //   }
  // }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    _controller.dispose();
    lengthCountLD.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textFormField = TextFormField(
      key: _fieldKey,
      textInputAction: widget.textInputAction,
      autofocus: widget.autoFocus,
      onEditingComplete: widget.onEditingComplete,
      enabled: widget.enabled,
      controller: _controller,
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      style: widget.textStyle,
      onFieldSubmitted: (str) =>
          widget.onFieldSubmitted?.call(_controller, str),
      validator: widget.validator == null
          ? null
          : (value) {
              var rs = widget.validator!(value);
              return rs;
            },
      onSaved: widget.onSaved,
      decoration: _getInputDecoration(context),
      buildCounter: widget.showTopMaxLength == true || !widget.showCounter
          ? (_, {required currentLength, maxLength, required isFocused}) => null
          : null,
    );
    if (widget.showTopMaxLength && widget.showCounter) {
      return Column(
        children: [
          Obx(() => '${lengthCountLD.value}/${widget.maxLength}'
              .text
              .textXS
              .caption(context)
              .make()).objectCenterRight(),
          Gaps.vGap4,
          textFormField,
        ],
      );
    }

    return textFormField;
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.radius);

    final border = OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: widget.borderColor ?? context.themeColor.gray.withOpacity(0.5),
        ));

    return InputDecoration(
        helperText: widget.helperText,
        contentPadding: widget.contentPadding,
        isDense: widget.contentPadding != null ? true : false,

        // Border
        enabledBorder: border,
        border: border,

        //
        filled: true,
        hintStyle:
            widget.hintStyle ?? TextStyle(color: Theme.of(context).hintColor),
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        fillColor: widget.backgroundColor ?? Theme.of(context).canvasColor,

        // Icons
        prefixIcon: _buildPrefixIcon(),
        prefixIconConstraints: const BoxConstraints(maxWidth: 62),
        suffixIcon: _buildSuffixButton(),
        suffixIconConstraints:
            BoxConstraints(maxWidth: widget.suffixMaxWidth ?? 62));
  }

  Widget? _buildPrefixIcon() {
    var iconData = widget.iconData;
    var iconSize = widget.iconSize;
    var iconPadding = widget.iconPadding;

    // final Color colorItem;
    // if (_state == TextFieldOutlineState.NOT_VALID) {
    //   colorItem = Theme.of(context).errorColor;
    // } else if ((_state == TextFieldOutlineState.NOT_EMPTY &&
    //     widget.colorOnFill) ||
    //     _focusNode.hasFocus) {
    //   colorItem = Theme.of(context).primaryColor;
    // } else {
    //   colorItem = Theme.of(context).lightGrey();
    // }

    return iconData != null
        ? _PrefixIcon(
            iconPadding: iconPadding,
            iconData: iconData,
            iconSize: iconSize,
            // colorItem: colorItem
          )
        : null;
  }

  Widget? _buildSuffixButton() {
    if (widget.suffix != null) {
      return widget.suffix;
    }

    if (widget.clearBtnBuilder != null) {
      return widget.clearBtnBuilder!(_controller, _showingClearBtn);
    }
    if (_showingClearBtn) {
      return BtnInputClear(onPress: () => _controller.clear()).px12();
    }
    return null;
  }
}

class _PrefixIcon extends StatelessWidget {
  const _PrefixIcon({
    Key? key,
    required this.iconPadding,
    required this.iconData,
    required this.iconSize,
    // required this.colorItem,
  }) : super(key: key);

  final EdgeInsetsGeometry? iconPadding;
  final IconData? iconData;
  final double? iconSize;

  // final Color? colorItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: iconPadding ?? const EdgeInsets.only(left: 10, right: 10),
      child: Icon(
        iconData,
        size: iconSize ?? 24,
        // color: colorItem,
      ),
    );
  }
}

class BtnInputClear extends StatelessWidget {
  const BtnInputClear({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return BtnCircleIcon(
      Icons.clear,
      onPress: onPress,
      backgroundColor: Colors.transparent,
      iconColor: context.themeColorText.textHint,
    );
  }
}
