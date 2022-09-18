import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/widgets/toast/ios_toast.dart';

class ToastUtils {
  static OverlaySupportEntry? _curToast;

  static void dismissToast() {
    _curToast?.dismiss();
  }

  static showToast(
      {required BuildContext context,
      required String msg,
      Duration? duration}) {
    if (!msg.isNullOrEmpty()) {
      _curToast?.dismiss();
      _curToast = showOverlay(
        (_, t) {
          return IosStyleToast(
            msg: msg,
          );
        },
        key: const ValueKey('overlay_toast'),
        duration: duration,
      );
    }
  }

}

class MessageNotification extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;

  const MessageNotification(
      {Key? key, this.title, this.subTitle, this.leading, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText2!.color!;

    final Widget titleWidget;
    final Widget? subTitleWidget;
    if (title == null) {
      titleWidget = subTitle?.text.color(textColor).make() ?? Gaps.empty;
      subTitleWidget = null;
    } else {
      titleWidget = title?.text.lg.medium.color(textColor).make() ?? Gaps.empty;
      subTitleWidget = subTitle?.text.color(textColor).make() ?? Gaps.empty;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      elevation: 5,
      child: SafeArea(
        child: ListTile(
          leading: leading,
          title: titleWidget,
          subtitle: subTitleWidget,
          trailing: trailing,
          horizontalTitleGap: 0.0,
        ),
      ),
    ).pOnly(top: 16);
  }
}
