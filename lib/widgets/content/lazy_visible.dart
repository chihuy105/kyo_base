import 'package:kyo_base/imports/base_component_import.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LazyVisible extends StatelessWidget {
  LazyVisible({
    Key? key,
    required this.parentBuilder,
    this.keyStr,
    required this.lazyChildBuilder,
    this.keyObject,
    this.offset = 10,
  }) : super(key: key);

  final Widget Function(BuildContext context, Widget obxChild) parentBuilder;
  final Widget Function(BuildContext context, bool isVisible) lazyChildBuilder;
  final String? keyStr;
  final Key? keyObject;
  final double offset;

  final isVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: keyObject ?? Key(keyStr ?? ''),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > offset && isVisible.value == false) {
          isVisible.value = true;
        }
        if (visiblePercentage < offset && isVisible.value == true) {
          isVisible.value = false;
        }
      },
      child: parentBuilder(
          context, Obx(() => lazyChildBuilder(context, isVisible.value))),
    );
  }
}
