import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/core/utils/data_utils.dart';
import 'package:kyo_base/widgets/image/photoview_utils.dart';
import 'package:photo_view/photo_view.dart';

class Img extends StatelessWidget {
  final String? src;
  final BoxFit fit;
  final bool canZoom;

  const Img(this.src,
      {Key? key, this.fit = BoxFit.fitWidth, this.canZoom = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorWidget = Container(
      color: Colors.grey[100],
      child: Assets.images.noImage.image(fit: fit),
    );

    if (src.isNullOrEmpty()) {
      return errorWidget;
    }
    Widget? imageWidget;

    if (src!.startsWith('http')) {
      var url = src!.startsWith('http://')
          ? src!.replaceFirst('http://', 'https://')
          : src!;

      if (src!.endsWith('.svg')) {
        return SvgPicture.network(src!, fit: fit);
      }

      imageWidget = CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const AppSkeleton(),
        memCacheHeight: 1000,
        errorWidget: (context, url, error) => const AppSkeleton(),
      );

      //! Not caching
      // return Image.network(
      //   url, fit: this.fit, loadingBuilder: (context, url, downloadProgress)=>CircularProgressIndicator(color: AppColor.primary,).centered(),
      //   errorBuilder: (context, url, error) => errorWidget
      // );
    }

    if (src!.contains('assets/')) {
      if (src!.contains('.svg')) {
        imageWidget = SvgPicture.asset(src!, fit: fit);
      } else {
        imageWidget = Image.asset(
          src!,
          fit: fit,
        );
      }
    } else if (src!.startsWith('/')) {
      imageWidget = Image.file(File(src!), fit: fit,);
    }

    if (imageWidget != null) {
      if (canZoom) {
        return GestureDetector(
          child: imageWidget,
          onTap: () => PhotoviewUtils.onZoomImage(context, src!),
        );
      }
      return imageWidget;
    }

    return Gaps.empty;
  }
}
