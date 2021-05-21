import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/utils/files/files_handler.dart';

mixin DartClassGenerator {
  void toDartString(
    List<YamlLine> listLines,
    String outputpath,
    String outputName,
  ) {
    final sb = StringBuffer();

    for (final node in listLines) {
      sb.writeln(node.line);
    }

    final op = mainDirectory + slash + outputpath;
    final fo = '$op/$outputName';

    createFolderUtils(op);
    deleteFileUtils(fo);
    createFileUtils(fo);
    writeFileUtils(fo, sb.toString());
    // File(fo).writeAsStringSync();
  }
}
