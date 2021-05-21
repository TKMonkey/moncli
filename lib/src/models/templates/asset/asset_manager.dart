import 'package:moncli/src/models/dartclass/dartclass_generator.dart';
import 'package:moncli/src/models/yaml/line/empty_line.dart';
import 'package:recase/recase.dart';

import '../../line.dart';
import 'asset_file.dart';

class AssetManager with DartClassGenerator {
  AssetManager({
    required this.name,
    required this.outputName,
    required this.outputPath,
    required this.data,
  });

  final String name;
  final String outputName;
  final String outputPath;
  final Iterable<AssetsFile> data;

  void write() {
    final rcName = ReCase(name);
    final rcOutputName = ReCase(outputName).snakeCase;
    final outName =
        rcOutputName.contains('.dart') ? rcOutputName : '$rcOutputName.dart';

    final List<Line> lines = [
      Line('class ${rcName.pascalCase} {'),
      Line('\t ${rcName.pascalCase}._();'),
      const EmptyLine(),
      for (final af in data)
        Line(
            "\tstatic const ${ReCase(af.outputVar).camelCase} = '${af.outputPath}';"),
      const Line('}'),
    ];

    toDartString(lines, 'lib/$outputPath', outName);
  }
}
