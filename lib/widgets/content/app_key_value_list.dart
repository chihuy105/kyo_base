import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/widgets/content/key_value_list_layout.dart';

class AppKeyValueList extends StatelessWidget {
  const AppKeyValueList({
    Key? key,
    required this.children,
    this.keyBuilder,
    this.separatorBuilder,
    this.crossAxisAlignment,
    this.showLastSeparator,
  }) : super(key: key);

  final List<dynamic> children;
  final Widget Function(BuildContext context, dynamic item)? keyBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool? showLastSeparator;

  @override
  Widget build(BuildContext context) {
    return KeyValueListLayoutBuilder<dynamic, dynamic>(
      children: children,
      crossAxisAlignment: crossAxisAlignment,
      keyBuilder: keyBuilder ??
          (BuildContext context, dynamic item) {
            if (item is String) {
              return item.text.make();
            } else if (item is Widget) {
              return item;
            }
            return Gaps.empty;
          },
      valueBuilder: (BuildContext context, dynamic item) {
        if (item is String) {
          return Flexible(
            flex: 3,
            child: item.text
                .align(TextAlign.right)
                .bold
                .make()
                .objectCenterRight(),
          );
        } else if (item is Widget) {
          return item;
        }
        return Gaps.empty;
      },
      separatorBuilder:
          separatorBuilder ?? (BuildContext context, int index) => Gaps.vGap16,
      showLastSeparator: showLastSeparator ?? false,
    );
  }
}
