import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/material.dart';

class IosStyleToast extends StatelessWidget {
  const IosStyleToast({Key? key, required this.msg, this.icon})
      : super(key: key);
  final String? msg;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: context.theme.colorScheme.onPrimary,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color:
                    context.theme.colorScheme.onSurface.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      icon!,
                    Flexible(child: msg?.text.center.make() ?? Gaps.empty),
                  ],
                ),
              ),
            ).maxWidth(maxWidth: ScreenUtils.getPercentWidth(percent: 0.6)),
          ),
        ),
      ),
    );
  }
}
