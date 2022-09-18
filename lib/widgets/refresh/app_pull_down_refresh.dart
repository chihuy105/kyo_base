import 'package:kyo_base/imports/base_component_import.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppPullDownRefresh extends StatefulWidget {
  const AppPullDownRefresh(
      {Key? key,
      required this.child,
      required this.refresh,
      this.enable = true})
      : super(key: key);

  final Widget child;
  final void Function() refresh;
  final bool enable;

  @override
  State<AppPullDownRefresh> createState() => _AppPullDownRefreshState();
}

class _AppPullDownRefreshState extends State<AppPullDownRefresh> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    if (!widget.enable) {
      return widget.child;
    }

    return CustomRefreshIndicator(
      child: widget.child,
      offsetToArmed: 80,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _) {
                return !controller.isIdle
                    ? AppLoading.defaultLoadingBox()
                    : Gaps.empty;
              },
            ).objectTopCenter(),
            child,
          ],
        );
      },
      onRefresh: () => Future.sync(
        () {
          if (mounted) {
            Future.delayed(const Duration(seconds: 1)).then((value) {
              if (mounted) {
                _refreshController.refreshCompleted();
              }
            });

            widget.refresh.call();
          }
        },
      ),
    );
  }
}
