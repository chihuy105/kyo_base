import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class AppTextLinkify extends StatelessWidget {
  const AppTextLinkify({Key? key, required this.text, this.style, this.linkStyle}) : super(key: key);

  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;

  @override
  Widget build(BuildContext context) {
    return Linkify(
      text: text,
      style: style,
      linkStyle: linkStyle,
      options: LinkifyOptions(humanize: false),
      onOpen: (link) async {
        LauncherUtils.showURL(context, link.url);
      },
    );
  }
}

