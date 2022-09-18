import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/widgets/header/header_tranparentable.dart';

class HeaderDetail extends StatelessWidget {
  const HeaderDetail({
    Key? key,
    required this.scrollController,
    this.title,
    this.iconDisappear = false,
    this.actionsBuilder,
    this.actionsCollapseBuilder,
    this.offset,
  }) : super(key: key);

  final TrackingScrollController scrollController;
  final String? title;
  final bool iconDisappear; //when appbar is transparent
  final List<Widget>? Function(Color iconColor, Color iconBackground)?
      actionsBuilder;
  final List<Widget>? Function(Color iconColor, Color iconBackground)?
      actionsCollapseBuilder;
  final double? offset;

  @override
  Widget build(BuildContext context) {
    return HeaderTransparentAble(
      scrollController: scrollController,
      // offset: offset ?? 200,
      rigid: _AppBar(
        isTransparent: false,
        title: title,
        actionsBuilder: actionsCollapseBuilder ?? actionsBuilder,
      ),
      transparent: _AppBar(
        iconDisappear: iconDisappear,
        actionsBuilder: actionsBuilder,
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final bool isTransparent;
  final String? title;
  final bool iconDisappear;
  final List<Widget>? Function(Color iconColor, Color iconBackground)?
      actionsBuilder;

  const _AppBar(
      {this.title,
      this.isTransparent = true,
      this.actionsBuilder,
      this.iconDisappear = false});

  @override
  Widget build(BuildContext context) {
    final Color iconColor;
    final Color iconBackground;

    if (iconDisappear && isTransparent) {
      iconColor = Colors.transparent;
      iconBackground = Colors.transparent;
    } else {
      iconColor = isTransparent ? Colors.white : Theme.of(context).primaryColor;
      iconBackground = isTransparent
          ? Colors.grey[600]!.withOpacity(0.3)
          : Colors.transparent;
    }

    final leadingBtn =
        isTransparent ? Colors.white : Theme.of(context).primaryColor;
    final leadingBg =
        isTransparent ? Colors.grey[600]!.withOpacity(0.3) : Colors.transparent;

    final listAction = actionsBuilder != null
        ? actionsBuilder!(iconColor, iconBackground)
        : [];

    return Row(
      children: [
        BtnBack(
          iconColor: leadingBtn,
          backgroundColor: leadingBg,
          isCupertino: false,
        ),
        title?.text.ellipsis.xl.semiBold.make().px4().expand() ?? Gaps.spacer,
        ...?listAction
      ],
    ).px16().py8();
  }
}
