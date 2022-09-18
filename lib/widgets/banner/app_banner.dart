import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/core/utils/view_utils.dart';
import 'package:kyo_base/widgets/skeleton/app_skeleton.dart';

part 'app_banner_controller.dart';

class AppBanner extends StatelessWidget {
  const AppBanner(
      {Key? key, required this.controller, required this.imageRatio})
      : super(key: key);

  final AppBannerController? controller;
  final double imageRatio;

  @override
  Widget build(BuildContext context) {
    if (controller == null) return Gaps.empty;

    return AspectRatio(
      aspectRatio: imageRatio,
      child: controller!.listCarousel.isNullOrEmpty() == true
          ? const AppSkeleton()
          : Stack(
              alignment: Alignment.bottomLeft,
              children: [
                PageView.builder(
                  controller: controller!.controller,
                  physics: const PageScrollPhysics(),
                  onPageChanged: (value) {
                    if (controller!.isOnSliding == false &&
                        controller!.curIndexLD.value != value) {
                      controller!.curIndexLD.value = value;
                    }
                  },
                  itemCount: controller?.listCarousel.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final currentValue =
                        controller!.listCarousel.getOrNull(index);
                    return Img(
                      currentValue,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.pad_XS2, vertical: Dimens.pad_XS3),
                  decoration: BoxDecoration(
                      color: context.themeColorText.textGray,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(Dimens.rad_XS),
                          bottomRight: Radius.circular(Dimens.rad_XS))),
                  child: Obx(() =>
                      '${controller!.curIndexLD.value + 1}/${controller!.imgList?.length}'
                          .text
                          .sm
                          .colorOnPrimary(context)
                          .make()),
                ).py12()
              ],
            ),
    );
  }
}

class AppBannerDot extends StatelessWidget {
  const AppBannerDot({
    Key? key,
    required this.controller,
    this.padding,
    required this.imageRatio,
    this.height = 65.0,
  }) : super(key: key);

  final AppBannerController? controller;
  final EdgeInsets? padding;
  final double height;
  final double imageRatio;

  static Widget loader({
    int itemCount = 5,
    required double imageRatio,
    required double height,
  }) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.pad_XS),
        separatorBuilder: (context, index) => Gaps.hGap8,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => AspectRatio(
          aspectRatio: imageRatio,
          child: const AppSkeleton().cornerRadius(
            Dimens.rad_L,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) return Gaps.empty;
    if (controller?.imgList?.isNotNullOrEmpty() == false) return Gaps.empty;

    const imageRad = Dimens.rad_XL;

    final previewWidgets = controller!.listPreview.mapAsList((img) => Img(
          img,
          fit: BoxFit.cover,
        ));

    final activeBoxDeco = BoxDecoration(
        borderRadius: BorderRadius.circular(imageRad),
        border: Border.all(color: context.theme.primaryColor, width: 2));
    final inActiveBoxDeco = BoxDecoration(
        borderRadius: BorderRadius.circular(imageRad),
        border: Border.all(color: Colors.transparent, width: 2));

    return Padding(
      padding: padding ?? Dimens.edge_zero,
      child: SizedBox(
        height: height,
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.pad_XS),
          separatorBuilder: (context, index) => Gaps.hGap8,
          itemCount: previewWidgets.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => AspectRatio(
            aspectRatio: imageRatio,
            child: GestureDetector(
              onTap: () {
                controller!.curIndexLD.value = index;
              },
              child: Obx(() {
                return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: controller!.curIndexLD.value == index
                        ? activeBoxDeco
                        : inActiveBoxDeco,
                    child: previewWidgets[index].cornerRadius(Dimens.rad_L));
              }),
            ),
          ),
        ),
      ),
    );
  }
}
