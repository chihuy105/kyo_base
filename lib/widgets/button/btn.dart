import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/cupertino.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum BtnType {
  PRIMARY,
  GRAY_PRIMARY,
  DELETE,
  GHOST,
  GHOST_SUCCESS,
  GHOST_BODY,
  GHOST_GRAY_BORDER,
  GHOST_GRAY,
  TEXT
}

class Btn extends StatelessWidget {
  const Btn({
    Key? key,
    this.btnType,
    this.padding,
    this.primaryColor,
    this.elevation,
    this.child,
    this.label,
    this.leading,
    this.loading = false,
    this.style,
    this.matchParent = false,
    this.fontWeight,
    this.fontSize,
    this.onPressed,
    this.isSubmit = false,
    this.loadingColor,
  }) : super(key: key);

  static const double btnHeightDefault = 42;

  // Data
  final Widget? child;
  final Widget? leading;
  final String? label;
  final bool loading;
  final Color? loadingColor;
  final bool isSubmit;

  // Set Style
  final BtnType? btnType;
  final ButtonStyle? style;

  // Set Style properties
  final Color? primaryColor;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final bool matchParent;

  // Text Style
  final FontWeight? fontWeight;
  final double? fontSize;

  // Action
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var finalFontWeight = fontWeight ?? FontWeight.w700;
    // Color? finalTextColor = context.theme.onPrimary();

    // Style
    final ButtonStyle? finalStyle;
    if (style != null) {
      finalStyle = style!;
    } else {
      switch (btnType) {
        case BtnType.PRIMARY:
        case null:
          finalStyle = AppButton.primaryStyle(context,
              props: BtnStyleProps(
                primaryColor: primaryColor,
                padding: padding,
                elevation: elevation,
              ));
          break;
        case BtnType.GRAY_PRIMARY:
          finalStyle = AppButton.grayPrimaryStyle(context,
              props: BtnStyleProps(
                primaryColor: primaryColor,
                padding: padding,
                elevation: elevation,
              ));
          break;
        case BtnType.GHOST:
          finalStyle = AppButton.ghostStyle(context,
              props: BtnStyleProps(
                primaryColor: primaryColor,
                padding: padding,
              ));
          break;
        case BtnType.GHOST_BODY:
          finalStyle = AppButton.ghostStyle(context,
              props: BtnStyleProps(
                borderColor: context.textTheme.bodyText2!.color,
                textColor: context.textTheme.bodyText2!.color,
                borderRadius: Dimens.rad_max,
                padding: Dimens.edge_btn_wide,
              ));
          break;
        case BtnType.GHOST_GRAY_BORDER:
          finalStyle = AppButton.ghostStyle(context,
              props: BtnStyleProps(
                primaryColor: primaryColor,
                padding: padding,
                textColor: context.theme.primaryColor,
                borderColor: context.theme.dividerColor,
              ));
          break;
        case BtnType.GHOST_GRAY:
          finalStyle = AppButton.ghostStyle(context,
              props: BtnStyleProps(
                primaryColor: primaryColor,
                padding: padding,
                textColor: context.textTheme.bodyText2!.color,
                borderColor: context.theme.dividerColor,
              ));
          break;
        case BtnType.GHOST_SUCCESS:
          finalStyle = AppButton.ghostStyle(context,
              props: BtnStyleProps(
                primaryColor: primaryColor ?? context.theme.onPrimary(),
                padding: padding,
                textColor: context.themeColor.success,
                borderColor: context.themeColor.success,
              ));
          break;
        case BtnType.DELETE:
          finalStyle = AppButton.deleteStyle(context,
              props: BtnStyleProps(
                  primaryColor: primaryColor,
                  padding: padding,
                  textColor: context.textTheme.bodyText2!.color,
                  borderColor: context.theme.dividerColor));
          break;
        case BtnType.TEXT:
          finalStyle = null;
          finalFontWeight = fontWeight ?? FontWeight.w600;
          break;
      }
    }

    final childWidget = label == null
        ? child
        : label?.text
            .fontWeight(finalFontWeight)
            .size(fontSize ?? Dimens.text)
            .make();

    final btnBody = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: matchParent ? MainAxisSize.max : MainAxisSize.min,
      children: [
        leading != null ? leading!.marginOnly(right: 4) : Gaps.empty,
        childWidget ?? Gaps.empty
      ],
    );

    var isDisable = false;
    if (isSubmit) {
      final form = ReactiveForm.of(context);
      isDisable = form?.valid ?? false ? false : true;
    }

    if (btnType == BtnType.TEXT) {
      return CupertinoButton(
        onPressed: loading ? () {} : (isDisable ? null : onPressed),
        padding: padding,
        minSize: 0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildLoading(context),
            (btnBody).opacity(value: loading ? 0 : 1)
          ],
        ),
      );
    }

    return ElevatedButton(
      onPressed: loading ? () {} : (isDisable ? null : onPressed),
      style: finalStyle,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildLoading(context),
          (btnBody).opacity(value: loading ? 0 : 1)
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return loading
        ? SizedBox(
            width: 18,
            height: 18,
            child: AppLoading.materialLoadingBox(
              context,
                strokeWidth: 2,
                size: 18,
                color: loadingColor ?? Theme.of(context).onPrimary()),
          )
        : Gaps.empty;
  }
}
