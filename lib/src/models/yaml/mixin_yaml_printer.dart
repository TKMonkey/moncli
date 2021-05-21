import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/yaml/line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

mixin YamlPrinterMixin {
  bool firstFont = false;

  /// Serializes [yaml] into a String and returns it.
  void toYamlString(
    Yaml yaml,
    List<YamlLine> listLines,
  ) {
    final sb = StringBuffer();

    for (final line in listLines) {
      line.writeIntoSink(sb, yaml);
    }
    File(outputPubPath).writeAsStringSync(sb.toString());
  }
}
