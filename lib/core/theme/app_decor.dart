import 'package:dotted_line/dotted_line.dart';
import 'package:kyo_base/imports/base_component_import.dart';

class AppDecor {
  static BoxDecoration bottomShadowDecor(
      {Color surfaceColor = Colors.transparent}) {
    return BoxDecoration(boxShadow: const <BoxShadow>[
      BoxShadow(color: Colors.grey, blurRadius: 1.0, offset: Offset(0.0, 1.0))
    ], color: surfaceColor);
  }

  static BoxDecoration boxShadow(
      {double rad = 20,
      BorderRadiusGeometry? borderRadius,
      double spreadRadius = 1.8,
      double blurRadius = 1,
      double shadowOpacity = 0.18,
      Color? shadowColor,
      BoxShape? shape,
      Offset? offset,
      Color? surfaceColor}) {
    return BoxDecoration(
      color: surfaceColor ?? Colors.white,
      borderRadius: shape == BoxShape.circle
          ? null
          : borderRadius ?? BorderRadius.circular(rad),
      shape: shape ?? BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
            color: shadowColor ?? Colors.grey.withOpacity(shadowOpacity),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            offset: offset ?? const Offset(0.0, 0.0)),
      ],
    );
  }

  static BoxDecoration borderPrimary(BuildContext context,
      {Color surfaceColor = Colors.transparent}) {
    return BoxDecoration(
        color: surfaceColor,
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.rad_S)));
  }

  static BoxDecoration borderWhiteBox(
    BuildContext context,
  ) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.rad),
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 0),
            spreadRadius: 1,
            blurRadius: 10,
          )
        ]);
  }

  static Widget dividerCircle(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 4.0,
      dashLength: 4.0,
      dashColor: Theme.of(context).unselectedWidgetColor,
      dashRadius: 50.0,
      dashGapLength: 6.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }

  static BoxDecoration outlineBorderTopCorner(
    BuildContext context,
  ) {
    return BoxDecoration(
      // border: Border.all(color: Colors.orange, width: 1),
      color: context.theme.primaryColor,
    );
  }

  static BoxDecoration cardBoxShadow(BuildContext context,
      {Color? color, BoxShape? shape}) {
    return BoxDecoration(
        color: color ?? context.theme.colorScheme.surface,
        borderRadius:
            shape == BoxShape.circle ? null : BorderRadius.circular(Dimens.rad),
        shape: shape ?? BoxShape.rectangle,
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(12, 26, 75, 0.24),
              blurRadius: 1,
              offset: Offset(0.0, 0.0)),
          BoxShadow(
              color: Color.fromRGBO(50, 50, 71, 0.05),
              blurRadius: Dimens.rad,
              offset: Offset(0.0, 3.0)),
        ]);
  }

  static BoxDecoration cardGrayBorder(BuildContext context,
      {Color? color,
      BoxShape? shape,
      BorderRadiusGeometry? borderRadius,
      double? borderWidth}) {
    return BoxDecoration(
        border: Border.all(
          width: borderWidth ?? 1,
          color: context.theme.dividerColor,
        ),
        color: color ?? context.theme.colorScheme.surface,
        shape: shape ?? BoxShape.rectangle,
        borderRadius: borderRadius);
  }

  static BoxDecoration stackingItemShadow(BuildContext context,
      {Color? color}) {
    return BoxDecoration(
      color: color ?? context.theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(Dimens.rad),
      border: Border.all(
        width: 1,
        color: const Color(0xFFE1E1E1),
      ),
      boxShadow: const [
        // BoxShadow(
        //     color: Color.fromRGBO(12, 26, 75, 0.24),
        //     blurRadius: 1,
        //     offset: Offset(0.0, 0.0)),
        BoxShadow(
            color: Color.fromRGBO(50, 50, 71, 0.05),
            blurRadius: Dimens.rad,
            offset: Offset(0.0, 3.0)),
      ],
    );
  }

  static BoxDecoration cardElevation(BuildContext context,
      {BorderRadiusGeometry? borderRadius}) {
    return BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(Dimens.rad),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(12, 26, 75, 0.24),
              blurRadius: 1,
              offset: Offset(0.0, 1.0)),
        ]);
  }

  static BoxDecoration grayBorder(BuildContext context,
      {BorderRadiusGeometry? borderRadius}) {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: context.theme.dividerColor,
      ),
      color: context.theme.colorScheme.surface,
      borderRadius: borderRadius ?? Dimens.rad_border_circular_L,
    );
  }

  static BoxDecoration primaryBorder(BuildContext context,
      {BorderRadiusGeometry? borderRadius}) {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: context.theme.primaryColor,
      ),
      borderRadius: borderRadius ?? Dimens.rad_border_circular_S,
    );
  }

  static BoxDecoration gray6(BuildContext context,
      {BorderRadiusGeometry? borderRadius}) {
    return BoxDecoration(
      color: context.themeColor.gray6,
      borderRadius: borderRadius ?? Dimens.rad_border_circular_S,
    );
  }
}
