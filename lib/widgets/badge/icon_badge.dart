import 'package:kyo_base/imports/base_component_import.dart';

class IconBadge extends StatelessWidget {
  final Widget icon;
  final int? badgeNumber;
  final double badgeFontSize;

  const IconBadge({
    Key? key,
    required this.icon,
    this.badgeNumber,
    this.badgeFontSize = 13.0,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        icon,
        Positioned(
          top: 0,
          left: 18,
          child: Visibility(
            visible: (badgeNumber != null && (badgeNumber ?? 0) > 0),
            child: Container(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.only(top: 1, left: 4, right: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(9),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                badgeNumber.toCountStr(),
                style: TextStyle(color: Colors.white, fontSize: badgeFontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
