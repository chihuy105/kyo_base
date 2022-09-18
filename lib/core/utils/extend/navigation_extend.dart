import 'package:kyo_base/imports/base_component_import.dart';

extension AutoRouteExtend on StackRouter {
  void popToParentOf(List<String> routeNameList,
      {VoidCallback? onNotFound, bool reverse = false}) {
    var stackList = stack;
    if (reverse) {
      stackList = stack.reversed.toList();
    }

    var index = stackList.indexWhere((item) =>
        routeNameList
            .find((itemRouteName) => item.routeData.name == itemRouteName) !=
        null);

    var parentRoute = stackList.getOrNull(index - 1);
    var name = parentRoute?.routeData.name;

    if (!name.isNullOrEmpty()) {
      popUntilRouteWithName(name!);
      return;
    }

    if (onNotFound != null) {
      onNotFound();
    } else {
      popUntilRoot();
    }
  }

  bool popToOf(List<String> routeNameList, {VoidCallback? onNotFound, bool reverse = false}) {
    var stackList = stack;
    if (reverse) {
      stackList = stack.reversed.toList();
    }
    var index = stackList.indexWhere((item) =>
        routeNameList
            .find((itemRouteName) => item.routeData.name == itemRouteName) !=
        null);

    var route = stackList.getOrNull(index);
    var name = route?.routeData.name;

    logger.i(name);

    if (!name.isNullOrEmpty()) {
      popUntilRouteWithName(name!, );
      return true;
    }

    if (onNotFound != null) {
      onNotFound();
      return false;
    }
    return false;
  }
}
