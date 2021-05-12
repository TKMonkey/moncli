import 'package:moncli/src/models/dartclass/dartclass_generator.dart';
import 'package:moncli/src/models/yaml/line.dart';
import 'package:recase/recase.dart';

import 'asset_file.dart';

//TODO Order output for name
// * Set comment with the name of subfolder

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
    final outName = rcOutputName.contains('.dart') ? rcOutputName : '$rcOutputName.dart';

    final List<Line> lines = [
      KeyLine('class ${rcName.pascalCase} {'),
      KeyLine('\t ${rcName.pascalCase}._();'),
      const EmptyLine(),
      for (final af in data)
        KeyLine("\tString get ${ReCase(af.outputVar).camelCase} => '${af.outputPath}';"),
      KeyLine('}'),
    ];

    toDartString(lines, 'lib/$outputPath', outName);
  }
}
