import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

ImageRender _networkImageRenderC({
  Map<String, String>? headers,
  double? width,
  double? height,
  Widget Function(String)? altWidget,
}) =>
    (context, attributes, element) {
      // print("parent: ${element!.parent!.localName}");
      if (element?.parent?.parent?.localName == 'picture') {
        return Container();
      }
      return SizedBox(
        width: Get.width,
        child: Img(
          attributes["src"],
          canZoom: true,
        ),
      ).objectCenter().cornerRadius(Dimens.rad_S);
    };

final Map<ImageSourceMatcher, ImageRender> _defaultImageRenders = {
  assetUriMatcher(): _networkImageRenderC(),
  networkSourceMatcher(extension: "svg"): _networkImageRenderC(),
  networkSourceMatcher(): _networkImageRenderC(),
};

class HtmlBody extends StatelessWidget {
  final String? data;
  final Map<String, Style>? mapStyle;

  const HtmlBody({Key? key, this.data, this.mapStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isNullOrEmpty()) {
      return 'contentIsUpdating'.tr.text.make().py8();
    }

    final htmlStyle = AppThemeTextExtension.getHtmlStyle(context);
    if (mapStyle != null) {
      htmlStyle.addAll(mapStyle!);
    }

    return Html(
      style: htmlStyle,
      shrinkWrap: false,
      customImageRenders: _defaultImageRenders,
      customRender: {
        "table": (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: (context.tree as TableLayoutElement).toWidget(context),
          );
        },
        // "picture": (context, child) {
        //   var a = context.tree.children;
        //   var b;
        //   a.forEach((element) {
        //     // print('element: ${element.attributes["type"]}');
        //     if (element.attributes["type"] == "image/webp") {
        //       String src = (element.attributes["srcset"]) ?? "";
        //       // print('src $src');
        //       b = SizedBox(width: Get.width, child: Img(src))
        //           .cornerRadius(Dimens.rad_S);
        //     }
        //   });
        //   return b;
        // },
        // "source": (context, child) {}
      },
      tagsList: Html.tags..addAll(["picture", "source"]),
      data: data!,
      onLinkTap: (url, context, attributes, element) {
        _handleLinkTap(url, context, attributes, element);
      },
    );
  }

  void _handleLinkTap(
    String? url,
    RenderContext context,
    Map<String, String> attributes,
    element,
  ) {
    if (url != null) {
      UrlLauncher.launchUrl(Uri.parse(url));
    }
  }
}
