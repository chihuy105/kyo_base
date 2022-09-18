import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/widgets/expansion/app_expanstion_title.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    Key? key,
    this.children,
    this.title,
    this.childrenPadding,
    this.topDivider = true,
    this.titleWidget,
    this.forward = false,
    this.onTap,
    this.onExpansionChanged,
    this.initiallyExpanded = true,
    this.expansionTileKey,
    this.expandedAlignment,
    this.tilePadding,
    this.visualDensity,
  }) : super(key: key);

  final List<Widget>? children;
  final String? title;
  final Widget? titleWidget;
  final EdgeInsetsGeometry? childrenPadding;
  final bool topDivider;
  final bool forward;
  final GestureTapCallback? onTap;
  final ValueChanged<bool>? onExpansionChanged;
  final bool initiallyExpanded;
  final Key? expansionTileKey;
  final Alignment? expandedAlignment;
  final EdgeInsetsGeometry? tilePadding;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (forward) {
      body = ListTile(
        title:
            titleWidget ?? title?.text.headline6(context).make() ?? Gaps.empty,
        trailing: Icon(
          Icons.navigate_next,
          color: context.theme.primaryColor,
        ),
        onTap: onTap,
      );
    } else {
      body = Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: AppExpansionTile(
          key: expansionTileKey,
          iconColor: context.theme.primaryColor,
          collapsedIconColor: context.theme.primaryColor,
          textColor: context.textTheme.bodyText2!.color,
          childrenPadding: childrenPadding ??
              const EdgeInsets.symmetric(horizontal: Dimens.pad_default),
          title: titleWidget ??
              title?.text.headline6(context).make() ??
              Gaps.empty,
          initiallyExpanded: initiallyExpanded,
          maintainState: true,
          onExpansionChanged: onExpansionChanged,
          expandedAlignment: expandedAlignment,
          tilePadding: tilePadding,
          visualDensity: visualDensity,
          children: children ?? [],
        ),
      );
    }

    if (topDivider == true) {
      return Column(
        children: [Gaps.divider, body],
      );
    }
    return body;
  }
}
