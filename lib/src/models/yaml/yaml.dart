import 'dart:io';

import 'package:meta/meta.dart';
import 'package:moncli/src/models/moncli_map.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/node/yaml_null_node.dart';
import 'package:yaml/yaml.dart';

/// MoncliMap specialized in Yaml files
class Yaml extends MoncliMap {
  static Map<String, INode> loadYamlMap(String yamlString) {
    return Map.of(
      (loadYaml(yamlString) as Map<dynamic, dynamic>).map(
        (key, value) => MapEntry(
          key as String,
          INode.create(value, YamlNodeFactory.sInstance),
        ),
      ),
    );
  }

  Yaml(
      {required Map<String, INode> internalMap,
      required List<String> fileLines})
      : super(const YamlNullNode(), internalMap) {
    _readPrimaryLines(fileLines);
  }

  factory Yaml.create(
      {required String yamlString, required List<String> fileLines}) {
    final internalMap = loadYamlMap(yamlString);

    return Yaml(internalMap: internalMap, fileLines: fileLines);
  }

  factory Yaml.fromFilePath(String filePath) {
    final file = File(filePath);

    return Yaml.create(
        yamlString: file.readAsStringSync(), fileLines: file.readAsLinesSync());
  }

  final _lines = <YamlLine>[];

  @override
  void operator []=(String key, INode value) {
    _addToLinesIfNeeded(key, value);
    super[key] = value;
  }

  void _readPrimaryLines(List<String> fileLines) {
    for (final line in fileLines) {
      final newLine = YamlLine.create(line);
      if (newLine != null) {
        _lines.add(newLine);
      }
    }
  }

  Iterable<YamlLine> get lines => List.unmodifiable(_lines);

  /// Serializes [yaml] into a String and returns it.
  @protected
  String toYamlString() {
    final sb = StringBuffer();

    for (final line in _lines) {
      line.writeIntoSink(sb, this);
    }
    return sb.toString();
  }

  void saveIntoFile(String filePath) {
    final yamlString = toYamlString();
    File(filePath).writeAsStringSync(yamlString);
  }

  /// Adds new line to lines if key is not currently in the yaml file
  void _addToLinesIfNeeded(String key, INode value) {
    if (containsKey(key)) {
      return;
    }

    final newLine = YamlLine.create('$key:');

    if (newLine == null) {
      return;
    }

    _lines.add(newLine);
  }
}
