import 'package:kyo_base/imports/base_component_import.dart';
import 'package:kyo_base/core/utils/file_utils.dart';
import 'package:kyo_base/widgets/file/file_item.dart';


class FileItemFromUrl extends StatelessWidget {
  const FileItemFromUrl({Key? key, required this.url, required this.alignLeft}) : super(key: key);

  final String url;
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    return FileDemo(
      extension: FileUtils.getExtensionFormPath(url),
      name: FileUtils.getNameFormPath(url),
      fileSize: null,
      // alignLeft: alignLeft,
    );
  }
}