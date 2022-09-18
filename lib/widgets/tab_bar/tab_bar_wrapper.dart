import 'package:kyo_base/imports/base_component_import.dart';

class TabBarWrapper extends StatelessWidget {
  const TabBarWrapper(
      {Key? key, required this.child, this.withBorder = true, this.themeData})
      : super(key: key);

  final Widget child;
  final bool withBorder;
  final ThemeData? themeData;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData ??
          context.theme.copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
      child: Container(
        decoration: withBorder == true
            ? BoxDecoration(
                color: context.theme.colorScheme.background,
                border: Border.all(color: context.theme.dividerColor),
                borderRadius: BorderRadius.circular(Dimens.rad_max),
              )
            : null,
        child: child,
      ),
    );
  }
}
