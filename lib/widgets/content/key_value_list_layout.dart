import 'package:kyo_base/imports/base_component_import.dart';

class KeyValueListLayout extends StatelessWidget {
  const KeyValueListLayout(
      {Key? key,
      this.children = const <Widget>[],
      this.separatorBuilder,
      this.crossAxisAlignment,
      this.showLastSeparator = false})
      : super(key: key);

  final List<Widget> children;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool showLastSeparator;

  @override
  Widget build(BuildContext context) {
    if (children.isNullOrEmpty()) {
      return Gaps.empty;
    }

    List<Widget> listPair = [];
    for (int i = 0; i < children.length; i += 2) {
      listPair.add(Row(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          children.getOrNull(i) ?? Gaps.empty,
          children.getOrNull(i + 1) ?? Gaps.empty,
        ],
      ));

      if (i == (children.length - 2)) {
        if (showLastSeparator) {
          listPair.add(
            separatorBuilder != null
                ? separatorBuilder!(context, i)
                : Gaps.empty,
          );
        }
      } else {
        listPair.add(
          separatorBuilder != null ? separatorBuilder!(context, i) : Gaps.empty,
        );
      }
    }

    return Column(
      children: listPair,
    );
  }
}

class KeyValueListLayoutBuilder<K, V> extends StatelessWidget {
  const KeyValueListLayoutBuilder({
    Key? key,
    required this.children,
    required this.separatorBuilder,
    required this.keyBuilder,
    required this.valueBuilder,
    this.showLastSeparator,
    this.crossAxisAlignment,
  }) : super(key: key);

  final List<dynamic> children;
  final Widget Function(BuildContext context, int index) separatorBuilder;
  final Widget Function(BuildContext context, K item) keyBuilder;
  final Widget Function(BuildContext context, V item) valueBuilder;
  final bool? showLastSeparator;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (children.isNullOrEmpty()) {
      return Gaps.empty;
    }

    return KeyValueListLayout(
      crossAxisAlignment: crossAxisAlignment,
      children: children.mapAsListIndexed((currentValue, index) {
        if (index % 2 != 0) {
          return valueBuilder(context, currentValue);
        }
        return keyBuilder(context, currentValue);
      }),
      separatorBuilder: separatorBuilder,
      showLastSeparator: showLastSeparator ?? false,
    );
  }
}

class KeyValueListLayoutBuilderIndex<K, V> extends StatelessWidget {
  const KeyValueListLayoutBuilderIndex({
    Key? key,
    required this.children,
    required this.separatorBuilder,
    required this.keyBuilder,
    required this.valueBuilder,
    this.showLastSeparator,
  }) : super(key: key);

  final List<dynamic> children;
  final Widget Function(BuildContext context, int index) separatorBuilder;
  final Widget Function(BuildContext context, K item, int index) keyBuilder;
  final Widget Function(BuildContext context, V item, int index) valueBuilder;
  final bool? showLastSeparator;

  @override
  Widget build(BuildContext context) {
    if (children.isNullOrEmpty()) {
      return Gaps.empty;
    }

    return KeyValueListLayout(
      children: children.mapAsListIndexed((currentValue, index) {
        if (index % 2 != 0) {
          return valueBuilder(context, currentValue, index ~/ 2);
        }
        return keyBuilder(context, currentValue, index);
      }),
      separatorBuilder: separatorBuilder,
      showLastSeparator: showLastSeparator ?? false,
    );
  }
}
