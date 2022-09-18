import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/widgets/button/actions/btn_more_text.dart';
import 'package:get/get.dart';

class ShowMoreLayout extends StatefulWidget {
  const ShowMoreLayout(
      {Key? key,
      required this.moreLayout,
      required this.lessLayout,
      this.defaultValue = false,
      this.moreBtnBuilder})
      : super(key: key);

  final Widget moreLayout;
  final Widget lessLayout;
  final Widget Function(bool isMore, VoidCallback onPressed)? moreBtnBuilder;
  final bool defaultValue;

  @override
  ShowMoreLayoutState createState() => ShowMoreLayoutState();
}

class ShowMoreLayoutState extends State<ShowMoreLayout> {
  final _showMoreLD = false.obs;

  @override
  void initState() {
    super.initState();
    _showMoreLD.value = widget.defaultValue;
  }

  @override
  void dispose() {
    _showMoreLD.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _showMoreLD.value
          ? _Layout(
              child: widget.moreLayout,
              isMore: true,
              moreBtnBuilder: widget.moreBtnBuilder,
              onPressed: _toggle)
          : _Layout(
              child: widget.lessLayout,
              isMore: false,
              moreBtnBuilder: widget.moreBtnBuilder,
              onPressed: _toggle);
    });
  }

  void _toggle() {
    _showMoreLD.value = !_showMoreLD.value;
  }
}

class _Layout extends StatelessWidget {
  const _Layout({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.isMore,
    this.moreBtnBuilder,
  }) : super(key: key);

  final bool isMore;
  final Widget child;
  final VoidCallback onPressed;
  final Widget Function(bool isMore, VoidCallback onPressed)? moreBtnBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        moreBtnBuilder != null
            ? moreBtnBuilder!(isMore, onPressed)
            : BtnMoreText(
                isMore: isMore,
                onPressed: onPressed,
              ).objectCenterRight().pt12()
      ],
    );
  }
}
