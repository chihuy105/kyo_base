import 'package:kyo_base/imports/base_component_import.dart';

enum AppAlertType { success, info, warning, error }

class AppAlert extends StatelessWidget {
  const AppAlert({Key? key, this.label, required this.type, this.subLabel})
      : super(key: key);

  final String? label;
  final String? subLabel;
  final AppAlertType type;

  static Color colorFormType(BuildContext context, AppAlertType type) {
    switch (type) {
      case AppAlertType.success:
        return context.themeColor.success;
      case AppAlertType.info:
        return context.themeColor.info;
      case AppAlertType.warning:
        return context.themeColor.warning;
      case AppAlertType.error:
        return context.themeColor.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color color = colorFormType(context, type);

    return Container(
      padding: Dimens.edge_default,
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(Dimens.rad_XS)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!label.isNullOrEmpty())
            label!.text.color(color).make(),
          if (!label.isNullOrEmpty() && !subLabel.isNullOrEmpty())
            Gaps.vGap4,
          if (!subLabel.isNullOrEmpty())
            subLabel!.text.make()
        ],
      ),
    );
  }
}
