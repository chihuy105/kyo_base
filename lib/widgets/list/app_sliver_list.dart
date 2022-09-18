import 'package:kyo_base/imports/base_component_import.dart';
import 'dart:math' as math;

class AppSliverList {

  static SliverList separated({
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required int itemCount,
  }) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return itemBuilder(context, itemIndex);
          }
          return separatorBuilder(context, itemIndex);
        },
        semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        },
        childCount: math.max(0, itemCount * 2 - 1),
      ),
    );
  }
}
