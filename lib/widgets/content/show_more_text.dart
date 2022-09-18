import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/core/utils/view_utils.dart';

class ShowMoreText extends StatelessWidget {
  const ShowMoreText(
      {Key? key,
      this.content,
      this.maxLines,
      this.textStyle,
      this.moreBtnBuilder})
      : super(key: key);

  final String? content;
  final TextStyle? textStyle;
  final int? maxLines;
  final Widget Function(bool isMore, VoidCallback onPressed)? moreBtnBuilder;

  @override
  Widget build(BuildContext context) {
    if (content.isNullOrEmpty()) {
      return Gaps.empty;
    }

    final finalMaxLines = maxLines ?? 8;
    final finalTextStyle = textStyle ?? context.textTheme.bodyText2!;
    final more = content!.text.textStyle(finalTextStyle).make();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        final textExceedMaxLines = ViewUtils.isTextExceedMaxLines(
          text: content!,
          style: finalTextStyle,
          maxLine: finalMaxLines,
          maxWidth: maxWidth,
        );
        return textExceedMaxLines
            ? ShowMoreLayout(
                moreLayout: more,
                moreBtnBuilder: moreBtnBuilder,
                lessLayout:
                    content!.text.textStyle(finalTextStyle).maxLines(finalMaxLines).ellipsis.make())
            : more;
      },
    );
  }
}
