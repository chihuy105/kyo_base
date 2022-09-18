import 'dart:typed_data';

import 'package:kyo_base/imports/base_component_import.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  FileUtils._();

  static const List<String> docFileTypes = [
    'mp3',
    'mp4',
    'pdf',
    'doc',
    'docx',
    'pdf',
    'xls',
    'xlsx',
  ];

  static const List<String> imageFileType = [
    'png',
    'jpg',
    'jpeg',
  ];

  static const List<String> imageAndDocFileType = [...docFileTypes, ...imageFileType];

  static bool isDocument(File file) {
    return FileUtils.docFileTypes.contains(
        FileUtils.getExtensionExceptDot(file));
  }

  static bool isImage(File file) {
    return FileUtils.imageFileType.contains(
        FileUtils.getExtensionExceptDot(file));
  }

  static bool isDocumentByPath(String path) {
    return FileUtils.docFileTypes.contains(
        FileUtils.getExtensionFormPathExceptDot(path));
  }

  static bool isImageByPath(String path) {
    return FileUtils.imageFileType.contains(
        FileUtils.getExtensionFormPathExceptDot(path));
  }

  static double getXFileSizeMB(XFile xFile) {
    return getFileSizeMB(File(xFile.path));
  }

  static double getFileSizeMB(File file) {
    try {
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      return sizeInMb;
    } catch (e) {
      logger.e(e);
      return 0;
    }
  }

  static String getFileSizeMBStr(File file) {
    return '${getFileSizeMB(file).toStringAsPrecision(2)}MB';
  }

  static String getExtension(File file) {
    return extension(file.path);
  }

  static String getExtensionExceptDot(File file) {
    return getExtension(file).substring(1);
  }

  static String getExtensionFormPath(String path) {
    return extension(path);
  }

  static String getExtensionFormPathExceptDot(String path) {
    return getExtensionFormPath(path).substring(1);
  }

  static String getName(File file) {
    return basename(file.path);
  }

  static String getNameFormPath(String path) {
    return basename(path);
  }

  static Future<File?> getFileFromUint8(Uint8List imageInUnit8List) async {
    try{
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(imageInUnit8List);
      return file;
    }catch(e) {
      logger.e(e);
    }
    return null;
  }

  static Future<List<File>?> getMultipleFile(
      {List<String>? allowedExtensions}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result != null) {
        List<File> files = result.paths
            .filter((item) => item.isNotNullOrEmpty())
            .map((path) => File(path!))
            .toList();
        return Future.value(files);
      } else {
        return Future.value();
      }
    } catch (e) {
      logger.e(e);
      return Future.error(e);
    }
  }
}
