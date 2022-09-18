import 'package:kyo_base/imports/base_component_import.dart';

class BtnStyleProps {
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final Color? primaryColor;
  final Color? borderColor;
  final double? borderRadius;
  final Color? textColor;
  final Size? minimumSize;

//<editor-fold desc="Data Methods">

  const BtnStyleProps({
    this.padding,
    this.elevation,
    this.primaryColor,
    this.borderColor,
    this.borderRadius,
    this.textColor,
    this.minimumSize,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BtnStyleProps &&
          runtimeType == other.runtimeType &&
          padding == other.padding &&
          elevation == other.elevation &&
          primaryColor == other.primaryColor &&
          borderColor == other.borderColor &&
          borderRadius == other.borderRadius &&
          textColor == other.textColor &&
          minimumSize == other.minimumSize);

  @override
  int get hashCode =>
      padding.hashCode ^
      elevation.hashCode ^
      primaryColor.hashCode ^
      borderColor.hashCode ^
      borderRadius.hashCode ^
      textColor.hashCode ^
      minimumSize.hashCode;

  @override
  String toString() {
    return 'BtnStyleProps{' +
        ' padding: $padding,' +
        ' elevation: $elevation,' +
        ' primaryColor: $primaryColor,' +
        ' borderColor: $borderColor,' +
        ' borderRadius: $borderRadius,' +
        ' textColor: $textColor,' +
        ' minimumSize: $minimumSize,' +
        '}';
  }

  BtnStyleProps copyWith({
    EdgeInsetsGeometry? padding,
    double? elevation,
    Color? primaryColor,
    Color? borderColor,
    double? borderRadius,
    Color? textColor,
    Size? minimumSize,
  }) {
    return BtnStyleProps(
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      primaryColor: primaryColor ?? this.primaryColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      textColor: textColor ?? this.textColor,
      minimumSize: minimumSize ?? this.minimumSize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'padding': this.padding,
      'elevation': this.elevation,
      'primaryColor': this.primaryColor,
      'borderColor': this.borderColor,
      'borderRadius': this.borderRadius,
      'textColor': this.textColor,
      'minimumSize': this.minimumSize,
    };
  }

  factory BtnStyleProps.fromMap(Map<String, dynamic> map) {
    return BtnStyleProps(
      padding: map['padding'] as EdgeInsetsGeometry,
      elevation: map['elevation'] as double,
      primaryColor: map['primaryColor'] as Color,
      borderColor: map['borderColor'] as Color,
      borderRadius: map['borderRadius'] as double,
      textColor: map['textColor'] as Color,
      minimumSize: map['minimumSize'] as Size,
    );
  }

//</editor-fold>
}

class AppButton {
  // Default Button Value
  static const double defaultRadius = Dimens.rad_XS;
  static const double defaultElevation = Dimens.elevation_zero;
  static const EdgeInsets defaultPadding =
      EdgeInsets.symmetric(horizontal: Dimens.pad_XL, vertical: Dimens.pad_XS);
  static const double defaultOpacity = 0.2;

  static ButtonStyle primaryStyle(BuildContext context,
      {BtnStyleProps? props}) {
    return ElevatedButton.styleFrom(
      minimumSize: props?.minimumSize,
      padding: props?.padding ?? defaultPadding,
      elevation: props?.elevation ?? defaultElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(props?.borderRadius ?? defaultRadius)),
      primary: props?.primaryColor ?? Theme.of(context).primaryColor,
      onPrimary: Theme.of(context).onPrimary(),
      shadowColor: Colors.transparent,
    );
  }

  static ButtonStyle grayPrimaryStyle(BuildContext context,
      {BtnStyleProps? props}) {
    return ElevatedButton.styleFrom(
      minimumSize: props?.minimumSize,
      padding: props?.padding ?? defaultPadding,
      elevation: props?.elevation ?? defaultElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(props?.borderRadius ?? defaultRadius)),
      primary: props?.primaryColor ?? context.themeColor.primaryLightest,
      onPrimary: Theme.of(context).primaryColor,
      shadowColor: Colors.transparent,
    );
  }

  static ButtonStyle ghostStyle(BuildContext context, {BtnStyleProps? props}) {
    var styleFrom = ElevatedButton.styleFrom(
        minimumSize: props?.minimumSize,
        padding: props?.padding ?? defaultPadding,
        elevation: props?.elevation ?? defaultElevation,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(props?.borderRadius ?? defaultRadius),
            side: BorderSide(
                color: props?.borderColor ?? context.theme.primaryColor)),
        shadowColor: Colors.transparent,
        primary: props?.primaryColor ?? Theme.of(context).onPrimary(),
        onPrimary: props?.textColor ?? context.theme.primaryColor,
        textStyle: context.theme.textTheme.button!
            .copyWith(fontWeight: FontWeight.w700));
    return styleFrom.copyWith(
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
        (states) => RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(props?.borderRadius ?? defaultRadius),
            side: BorderSide(
                color: states.contains(MaterialState.disabled)
                    ? context.theme.disabledColor
                    : (props?.borderColor ?? context.theme.primaryColor))),
      ),
    );
  }

  static ButtonStyle deleteStyle(BuildContext context, {BtnStyleProps? props}) {
    return ElevatedButton.styleFrom(
      minimumSize: props?.minimumSize,
      padding: props?.padding ?? defaultPadding,
      elevation: props?.elevation ?? defaultElevation,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(props?.borderRadius ?? defaultRadius)),
      primary: props?.primaryColor ?? context.themeColor.error,
      onPrimary: Theme.of(context).onPrimary(),
      shadowColor: Colors.transparent,
    );
  }

  static ButtonStyle textStyle(BuildContext context, {BtnStyleProps? props}) {
    return TextButton.styleFrom(
      minimumSize: props?.minimumSize,
      padding: props?.padding ?? const EdgeInsets.all(0),
      elevation: props?.elevation ?? 0,
      primary: props?.primaryColor ?? Theme.of(context).primaryColor,
      backgroundColor: Colors.transparent,
    );
  }

  static ButtonStyle textStyleAccent(BuildContext context,
      {BtnStyleProps? props}) {
    return TextButton.styleFrom(
      minimumSize: props?.minimumSize,
      padding: props?.padding ?? const EdgeInsets.all(0),
      elevation: props?.elevation ?? 0,
      primary: props?.primaryColor ?? Theme.of(context).primaryColor,
      backgroundColor: Colors.transparent,
    );
  }

  static ButtonStyle textStyleLink(BuildContext context,
      {BtnStyleProps? props}) {
    return TextButton.styleFrom(
      minimumSize: props?.minimumSize,
      padding: props?.padding ?? const EdgeInsets.all(0),
      elevation: props?.elevation ?? 0,
      primary: props?.primaryColor ?? context.themeColorText.textLink,
      backgroundColor: Colors.transparent,
    );
  }
}
