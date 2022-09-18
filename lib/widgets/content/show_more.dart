import 'package:kyo_base/imports/base_component_import.dart';

class ShowMore extends StatefulWidget {
  final Widget? child;
  final Widget Function(bool showMore, GestureTapCallback onTap)?
      moreBtnBuilder;
  final double? minHeight;
  final bool defaultValue;

  const ShowMore({
    Key? key,
    required this.child,
    this.minHeight,
    this.moreBtnBuilder,
    this.defaultValue = false,
  }) : super(key: key);

  @override
  ShowMoreState createState() => ShowMoreState();
}

class ShowMoreState extends State<ShowMore> {
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
    if (widget.child == null) {
      return Gaps.empty;
    }

    final Widget full = Column(
      children: [
        widget.child!,
        widget.moreBtnBuilder != null
            ? widget.moreBtnBuilder!(true, _showLess)
            : Btn(
                label: 'viewLess'.tr,
                btnType: BtnType.TEXT,
                onPressed: _showLess,
              ).py8()
      ],
    );

    final Widget less = Column(
      children: [
        SizedBox(height: widget.minHeight, child: widget.child!),
        widget.moreBtnBuilder != null
            ? widget.moreBtnBuilder!(false, _showMore)
            : Btn(
                label: 'viewMore'.tr,
                btnType: BtnType.TEXT,
                onPressed: _showMore,
              )
      ],
    );

    return Obx(() {
      return _showMoreLD.value ? full : less;
    });
  }

  void _showLess() {
    _showMoreLD.value = false;
  }

  void _showMore() {
    _showMoreLD.value = true;
  }
}
