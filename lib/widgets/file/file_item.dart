import 'package:kyo_base/imports/base_component_import.dart';

class FileDemo extends StatelessWidget {
  const FileDemo({
    Key? key,
    required this.name,
    required this.extension,
    required this.fileSize,
    this.alignLeft = true,
    this.indicator,
    this.opacityValue = 1.0,
    this.fileIcHeight = 70,
  }) : super(key: key);

  final String name;
  final String? extension;
  final String? fileSize;
  final bool alignLeft;
  final Widget? indicator;
  final double opacityValue;
  final double fileIcHeight;

  @override
  Widget build(BuildContext context) {
    if (name.isNullOrEmpty()) return Gaps.empty;

    final icon = SizedBox(
      height: 70,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: Assets.icons.fileIc.svg(
                color: context.theme.primaryColor,
              ),
            ),
            if (extension.isNotNullOrEmpty())
              Row(
                children: [
                  Container(
                    color: context.theme.onPrimary(),
                    child: extension!
                        .toUpperCase()
                        .replaceFirst('.', '')
                        .text
                        .center
                        .size(Dimens.text_XS2)
                        .colorGray5(context)
                        .make(),
                  ).expand(),
                ],
              ).pb8(),
          ],
        ),
      ),
    ).opacity(value: opacityValue);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          alignLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (alignLeft) icon,
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                alignLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              if (name.isNotNullOrEmpty())
                name.textAuto.textS
                    .align(alignLeft ? TextAlign.start : TextAlign.end)
                    .bold
                    .maxLines(2)
                    .ellipsis
                    .make()
                    .pb4(),
              (fileSize ?? '').text.textMidXS.colorGray5(context).make(),
              if (indicator != null)
                Align(
                  alignment:
                      alignLeft ? Alignment.centerRight : Alignment.centerLeft,
                  child: indicator ?? Gaps.empty,
                ),
            ],
          ).pOnly(
            left: alignLeft ? Dimens.gap_dp8 : 0,
            right: alignLeft ? 0 : Dimens.gap_dp8,
          ),
        ),
        if (!alignLeft) icon,
      ],
    ).maxWidth(maxWidth: 160);
  }
}
