import 'dart:io' as io show File;

import 'package:kyo_base/imports/base_component_import.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  ImageUtils._();

  static Future<File?> getImageFromLibrary(ImagePicker imagePicker) async {
    try {
      final result = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 60);
      if (result != null) {
        return Future.value(File(result.path));
      } else {
        return Future.value();
      }
    } catch (e) {
      logger.e(e);
      return Future.error(e);
    }
  }

  // static Future<File?> resizeImage(File file) async {
  //   try {
  //     File compressedFile = await FlutterNativeImage.compressImage(
  //       file.path,
  //       quality: quality,
  //       percentage: percentage,
  //     );
  //
  //     return Future.value(compressedFile);
  //   } catch (e) {
  //     logger.e(e);
  //     return Future.error(e);
  //   }
  // }

  static Future<List<File>?> getMultipleImageFromLibrary(
      ImagePicker imagePicker) async {
    try {
      final result = await imagePicker.pickMultiImage(imageQuality: 60);
      if (result != null) {
        return Future.value(result.mapAsList((item) => File(item.path)));
      } else {
        return Future.value();
      }
    } catch (e) {
      logger.e(e);
      return Future.error(e);
    }
  }

  static Future<io.File> getImageFromPath(
      String? path, String? fileName) async {
    if (path == null || fileName == null) {
      throw Exception("File path or file name cannot be null");
    }
    return io.File('$path/$fileName');
  }

  static Future<io.File?> saveImageToPath(
    io.File? sourceImage,
    String? path,
    String? fileName,
  ) async {
    if (sourceImage == null || path == null || fileName == null) return null;
    final io.File newImage = await sourceImage.copy('$path/$fileName');
    return newImage;
  }

}
