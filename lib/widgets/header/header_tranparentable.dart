import 'package:kyo_base/imports/base_component_import.dart';

class HeaderTransparentAble extends StatefulWidget {
  final TrackingScrollController scrollController;
  final Widget transparent;
  final Widget rigid;
  final bool transparentNull;
  final double startOffset;
  final double offset;

  const HeaderTransparentAble({
    Key? key,
    required this.scrollController,
    required this.transparent,
    required this.rigid,
    this.transparentNull = false,
    this.startOffset = 0,
    this.offset = 300,
  }) : super(key: key);

  @override
  _HeaderTransparentAleState createState() => _HeaderTransparentAleState();
}

class _HeaderTransparentAleState extends State<HeaderTransparentAble> {
  final _opacityLD = 0.0.obs;

  @override
  void initState() {
    widget.scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _opacityLD.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rigidWrap = _RigidWrap(widget: widget);

    final transparentWrapper = widget.transparentNull
        ? Obx(() => Opacity(
              opacity: 1 - _opacityLD.value,
              child: widget.transparent,
            ))
        : widget.transparent;

    return Stack(
      children: [
        SafeArea(bottom: false, child: transparentWrapper),
        Obx(() {
          final opacityValue = _opacityLD.value;
          return IgnorePointer(
            ignoring: (1 - opacityValue) == 1,
            child: Opacity(
              opacity: _opacityLD.value,
              child: rigidWrap,
            ),
          );
        }),
      ],
    );
  }

  void _onScroll() {
    final scrollOffset = widget.scrollController.offset - widget.startOffset;

    double opacityValue = _opacityLD.value;
    if (scrollOffset > 0) {
      opacityValue = scrollOffset / widget.offset;
    } else if (scrollOffset <= 0) {
      opacityValue = 0.0;
    }

    if (opacityValue >= 1.0) {
      opacityValue = 1.0;
    }
    if(_opacityLD.value != opacityValue){
      _opacityLD.value = opacityValue;
    }
  }
}

class _RigidWrap extends StatelessWidget {
  const _RigidWrap({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final HeaderTransparentAble widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecor.boxShadow(
          surfaceColor: Theme.of(context).appBarTheme.backgroundColor,
          rad: 0,
          shadowOpacity: 0.3,
          spreadRadius: 4,
          blurRadius: 5),
      child: SafeArea(
        bottom: false,
        child: widget.rigid,
      ),
    );
  }
}
