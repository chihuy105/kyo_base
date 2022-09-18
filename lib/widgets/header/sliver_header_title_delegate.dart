import 'package:kyo_base/imports/base_component_import.dart';

class SliverHeaderTitleDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Widget title;
  final Widget appBarExtend;
  final Widget appBarCollapse;
  final double minHeight;
  final double maxHeight;

  const SliverHeaderTitleDelegate({
    required this.child,
    required this.title,
    required this.appBarExtend,
    required this.appBarCollapse,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      final double perExtend =
          (constraints.maxHeight - minExtent) / (maxExtent - minExtent);
      final double perCollapse = 1 - perExtend;

      final double extendScale = (perExtend <= 0.1) ? perExtend/0.1 : 1;
      final double extendOp = (perExtend <= 0.2) ? perExtend/0.2 : 1;
      final double collapseOp = 1 - extendOp;
      print('BUILD => ${(SliverHeaderTitleDelegate).toString()} ${extendOp.toString()}');

      return Container(
        color: Colors.lightBlue,
        height: constraints.maxHeight,
        child: SizedBox.expand(
          child: Stack(
            children: [
              Opacity(
                opacity: extendOp,
                child: SizedBox.expand(
                  child: appBarExtend,
                ),
              ),
              Opacity(
                opacity: collapseOp,
                child: SizedBox.expand(
                  child: appBarCollapse,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // @override
  // bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  bool shouldRebuild(SliverHeaderTitleDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight ||
      minHeight != oldDelegate.minHeight ||
      child != oldDelegate.child;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}
