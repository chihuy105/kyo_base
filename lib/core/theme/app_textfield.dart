import 'package:kyo_base/imports/base_component_import.dart';

class InputStyleProps {
  final double? iconSize;
  final double radius;
  final double borderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final bool showBorder;

  final String? helperText;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? suffixIconWidth;

  final Widget? counter;

//<editor-fold desc="Data Methods">

  const InputStyleProps({
    this.counter,
    this.helperText,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconWidth,
    this.iconSize,
    this.radius = AppTextField.defaultRadius,
    this.borderWidth = AppTextField.defaultRadius,
    this.contentPadding = AppTextField.defaultPadding,
    this.backgroundColor,
    this.hintStyle,
    this.showBorder = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InputStyleProps &&
          runtimeType == other.runtimeType &&
          iconSize == other.iconSize &&
          radius == other.radius &&
          borderWidth == other.borderWidth &&
          contentPadding == other.contentPadding &&
          backgroundColor == other.backgroundColor &&
          hintStyle == other.hintStyle &&
          showBorder == other.showBorder &&
          helperText == other.helperText &&
          hintText == other.hintText &&
          labelText == other.labelText &&
          prefixIcon == other.prefixIcon &&
          suffixIcon == other.suffixIcon &&
          suffixIconWidth == other.suffixIconWidth &&
          counter == other.counter);

  @override
  int get hashCode =>
      iconSize.hashCode ^
      radius.hashCode ^
      borderWidth.hashCode ^
      contentPadding.hashCode ^
      backgroundColor.hashCode ^
      hintStyle.hashCode ^
      showBorder.hashCode ^
      helperText.hashCode ^
      hintText.hashCode ^
      labelText.hashCode ^
      prefixIcon.hashCode ^
      suffixIcon.hashCode ^
      suffixIconWidth.hashCode ^
      counter.hashCode;

  @override
  String toString() {
    return 'InputStyleProps{' +
        ' iconSize: $iconSize,' +
        ' radius: $radius,' +
        ' borderWidth: $borderWidth,' +
        ' contentPadding: $contentPadding,' +
        ' backgroundColor: $backgroundColor,' +
        ' hintStyle: $hintStyle,' +
        ' showBorder: $showBorder,' +
        ' helperText: $helperText,' +
        ' hintText: $hintText,' +
        ' labelText: $labelText,' +
        ' prefixIcon: $prefixIcon,' +
        ' suffixIcon: $suffixIcon,' +
        ' suffixIconWidth: $suffixIconWidth,' +
        ' counter: $counter,' +
        '}';
  }

  InputStyleProps copyWith({
    double? iconSize,
    double? radius,
    double? borderWidth,
    EdgeInsetsGeometry? contentPadding,
    Color? backgroundColor,
    TextStyle? hintStyle,
    bool? showBorder,
    String? helperText,
    String? hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    double? suffixIconWidth,
    Widget? counter,
  }) {
    return InputStyleProps(
      iconSize: iconSize ?? this.iconSize,
      radius: radius ?? this.radius,
      borderWidth: borderWidth ?? this.borderWidth,
      contentPadding: contentPadding ?? this.contentPadding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hintStyle: hintStyle ?? this.hintStyle,
      showBorder: showBorder ?? this.showBorder,
      helperText: helperText ?? this.helperText,
      hintText: hintText ?? this.hintText,
      labelText: labelText ?? this.labelText,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      suffixIconWidth: suffixIconWidth ?? this.suffixIconWidth,
      counter: counter ?? this.counter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'iconSize': this.iconSize,
      'radius': this.radius,
      'borderWidth': this.borderWidth,
      'contentPadding': this.contentPadding,
      'backgroundColor': this.backgroundColor,
      'hintStyle': this.hintStyle,
      'showBorder': this.showBorder,
      'helperText': this.helperText,
      'hintText': this.hintText,
      'labelText': this.labelText,
      'prefixIcon': this.prefixIcon,
      'suffixIcon': this.suffixIcon,
      'suffixIconWidth': this.suffixIconWidth,
      'counter': this.counter,
    };
  }

  factory InputStyleProps.fromMap(Map<String, dynamic> map) {
    return InputStyleProps(
      iconSize: map['iconSize'] as double,
      radius: map['radius'] as double,
      borderWidth: map['borderWidth'] as double,
      contentPadding: map['contentPadding'] as EdgeInsetsGeometry,
      backgroundColor: map['backgroundColor'] as Color,
      hintStyle: map['hintStyle'] as TextStyle,
      showBorder: map['showBorder'] as bool,
      helperText: map['helperText'] as String,
      hintText: map['hintText'] as String,
      labelText: map['labelText'] as String,
      prefixIcon: map['prefixIcon'] as Widget,
      suffixIcon: map['suffixIcon'] as Widget,
      suffixIconWidth: map['suffixIconWidth'] as double,
      counter: map['counter'] as Widget,
    );
  }

//</editor-fold>
}

class AppTextField {
  // Default Value
  static const double defaultRadius = Dimens.rad_XS;
  static const double defaultBorderWidth = 2;
  static const EdgeInsets defaultPadding =
      EdgeInsets.symmetric(vertical: 12, horizontal: 14);
  static const double defaultOpacity = 0.2;

  static InputDecoration primaryStyle(BuildContext context,
      {InputStyleProps? inputStyleProps}) {
    final props = inputStyleProps ?? const InputStyleProps();
    final borderRadius = BorderRadius.circular(props.radius);

    final outlineInputBorder = OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: context.theme.dividerColor,
        ));

    return InputDecoration(
        helperText: props.helperText,
        contentPadding: props.contentPadding,
        isDense: props.contentPadding != null ? true : false,

        counter: props.counter,

        // Border
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,

        //
        filled: true,
        hintStyle: props.hintStyle ?? context.themeText.textHint,
        hintText: props.hintText,
        labelText: props.labelText,
        fillColor: props.backgroundColor ?? Theme.of(context).canvasColor,

        // Icons
        prefixIcon: props.prefixIcon,
        prefixIconConstraints: const BoxConstraints(maxWidth: 62),
        suffixIcon: props.suffixIcon,
        suffixIconConstraints:
            BoxConstraints(maxWidth: props.suffixIconWidth ?? 62));
  }
}
