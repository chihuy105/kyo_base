import 'dart:math';

import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/core/utils/data_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CarouselZoom extends StatefulWidget {
  const CarouselZoom({Key? key, required this.imgSrc}) : super(key: key);

  final List<String>? imgSrc;

  @override
  _CarouselZoomState createState() => _CarouselZoomState();
}

class _CarouselZoomState extends State<CarouselZoom> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (widget.imgSrc.isNullOrEmpty()) return Gaps.empty;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BtnBack(
          onPress: () => Navigator.pop(context),
          isCupertino: false,
        ),
      ),
      body: GestureDetector(
        onTap: () => context.router.pop(),
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PhotoViewGallery.builder(
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider:
                        NetworkImage(widget.imgSrc![index] ?? ''),
                    maxScale: 2.0,
                    minScale: PhotoViewComputedScale.contained,
                    initialScale: PhotoViewComputedScale.contained,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: DataUtils.generateTag()),
                  );
                },
                itemCount: widget.imgSrc?.length,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: AppLoading.defaultLoadingBox(
                              strokeWidth: 2,
                              size: 33,
                              color: context.theme.primaryColor)
                          .centered()),
                ),
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                pageController: _pageController,
                // onPageChanged: onPageChanged,
              ),
              // SmoothPageIndicator(
              //   controller: _pageController,
              //   count: widget.imgModels?.length??0,
              //   effect: ExpandingDotsEffect(
              //       activeDotColor:
              //           Theme.of(context).canvasColor.withOpacity(0.98),
              //       dotColor: Theme.of(context).canvasColor.withOpacity(0.95),
              //       dotHeight: 6,
              //       dotWidth: 6,
              //       expansionFactor: 3),
              // ).pOnly(bottom: 30),
            ],
          ),
        ),
      ),
    );
  }
}
