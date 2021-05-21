import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/yaml/line.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

mixin YamlPrinterMixin {
  bool firstFont = false;

  /// Serializes [yaml] into a String and returns it.
  void toYamlString(
    Yaml yaml,
    List<YamlLine> listLines,
  ) {
    final sb = StringBuffer();

    for (final node in listLines) {
      if (node is KeyLine) {
        final sbk = StringBuffer();
        writeYamlString(
            YamlNodeFactory.sInstance.createMapNode({node.key: yaml[node.key]}),
            sbk);

        /// moves text to be inline with [hyphen '-']
        sb.write(sbk.toString().replaceAll(RegExp(r'-\s\n\s*'), '- '));
      } else {
        sb.writeln(node.line);
      }
    }
    File(outputPubPath).writeAsStringSync(sb.toString());
  }

  /// Serializes [node] into a String and writes it to the [sink].
  void writeYamlString(INode node, StringSink sink) {
    _writeYamlType(node, 0, sink, true);
  }

  void _writeYamlType(INode node, int indent, StringSink ss, bool isTopLevel) {
    final yamlString = node.toSerializedString(indent, isTopLevel);
    ss.write(yamlString);
  }
}
