import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/foundation.dart';

class AppWebView extends StatefulWidget {
  const AppWebView({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  AppWebViewState createState() => AppWebViewState();
}

class AppWebViewState extends State<AppWebView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      allowsInlineMediaPlayback: true,
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      gestureRecognizers: Set()
        ..add(
          Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
          ),
        ),
    );
  }
}

