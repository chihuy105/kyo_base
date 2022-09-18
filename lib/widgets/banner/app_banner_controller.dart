part of 'app_banner.dart';

class AppBannerController {
  AppBannerController({this.imgList, required this.bannerHeight});

  factory AppBannerController.fromRatio(
      {List<String>? imgList,
      required BuildContext context,
      required double ratio}) {
    final height = ScreenUtils.heightFormRatio(ratio: ratio);

    return AppBannerController(imgList: imgList, bannerHeight: height);
  }

  final List<String>? imgList;
  final double bannerHeight;

  final controller = PageController();
  final curIndexLD = 0.obs;
  final listCarousel = <String>[];
  final listPreview = <String>[];
  var isOnSliding = false;
  StreamSubscription<int>? streamListen;

  void init() {
    streamListen?.cancel();
    streamListen = curIndexLD.listen((value) {
      isOnSliding = true;
      // _controller.jumpToPage(value);
      controller
          .animateToPage(
        value,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      )
          .then((value) {
        isOnSliding = false;
      });
    });

    listCarousel.addAll(imgList ?? []);
    listPreview.addAll(imgList ?? []);
  }

  void updateImageList(List<String> imageList) {}

  Future<void> dispose() async {
    await streamListen?.cancel();
  }
}
