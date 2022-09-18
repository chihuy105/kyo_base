import 'package:kyo_base/imports/base_component_import.dart';

/// Author: Kyo Huu
/// Create date: 7/25/2020

/// Use Hero for Widget that's not Image

class TextHero extends StatelessWidget {

  final Widget? child;
  final String? tag;

  const TextHero({Key? key, required this.child, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return Gaps.empty;
    }
    return Hero(
      flightShuttleBuilder: _flightShuttleBuilder,
      tag: tag.isEmptyOrValue(UniqueKey()),
      child: child!,
    );
  }
}

Widget _flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}
