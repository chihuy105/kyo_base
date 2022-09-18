import 'package:kyo_base/imports/base_component_import.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoviewUtils {
  PhotoviewUtils._();

  static onZoomImage(BuildContext context, String src) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) {
          return GestureDetector(
            onTap: () => Navigator.of(context, rootNavigator: true).pop(),
            child: PhotoView(
              imageProvider: getImageProvider(src),
              backgroundDecoration: const BoxDecoration(color: Colors.black38),
              maxScale: 2.0,
              // enableRotation: true,
              minScale: PhotoViewComputedScale.contained,
              heroAttributes: PhotoViewHeroAttributes(tag: src),
            ),
          );
        },
      ),
    );
  }

  static onZoomLibrary(BuildContext context, List<String> srcList,
      {int? initialPage}) {
    final minScale = PhotoViewComputedScale.contained * 0.8;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) {
          return GestureDetector(
            onTap: () => Navigator.of(context, rootNavigator: true).pop(),
            child: PhotoViewGallery.builder(
              scrollPhysics: const ClampingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: getImageProvider(srcList.getOrNull(index)),
                  initialScale: minScale,
                  minScale: minScale,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: srcList.getOrNull(index)!),
                );
              },
              itemCount: srcList.length,
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            (event.expectedTotalBytes as num),
                  ),
                ),
              ),
              backgroundDecoration: const BoxDecoration(color: Colors.black38),
              pageController: PageController(initialPage: initialPage ?? 0),
              // onPageChanged: onPageChanged,
            ),
          );
        },
      ),
    );
  }

  static onZoomLibraryPage(BuildContext context, List<String> srcList,
      {int? initialPage}) {}

  static ImageProvider getImageProvider(String? src) {
    if (src?.startsWith('http') == true) {
      var url = src!.startsWith('http://')
          ? src.replaceFirst('http://', 'https://')
          : src;

      return NetworkImage(url);
    }
    if (src?.contains('assets/') == true) {
      return AssetImage(src!);
    }
    if ((src?.length ?? 0) > 1 && src?.substring(0, 1) == '/') {
      return FileImage(File(src ?? ''));
    }

    logger.i(src);

    return NetworkImage(src ?? '');
  }
}
