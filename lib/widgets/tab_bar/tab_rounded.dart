import 'package:kyo_base/imports/base_component_import.dart';

class TabRounded extends StatefulWidget {
  const TabRounded({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.index,
  }) : super(key: key);

  final String? label;
  final bool isSelected;
  final int index;

  @override
  State<TabRounded> createState() => _TabRoundedState();
}

class _TabRoundedState extends State<TabRounded> {
  @override
  Widget build(BuildContext context) {
    final gray = context.themeColorText.textHint;
    final primaryColor = context.theme.primaryColor;

    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: widget.isSelected
              ? primaryColor
              : context.themeColorText.textHintLight,
          width: 1,
        ),
        color: widget.isSelected ? primaryColor : Colors.transparent,
      ),
      child: widget.label?.text
          .color(
        widget.isSelected ? context.theme.onPrimary() : gray,
      )
          .bold
          .size(Dimens.text_S)
          .maxLines(2)
          .center
          .make()
          .maxWidth(maxWidth: 120)
          .px12()
          .objectCenter() ??
          Gaps.empty,
    );
  }
}
