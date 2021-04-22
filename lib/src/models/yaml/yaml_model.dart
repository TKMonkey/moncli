import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/yaml/yaml_functions.dart';
import 'package:yaml/yaml.dart';

import '../node_model.dart';

class YamlModel with YamlFunctions {
  YamlModel.pubspec({bool isDev = false, bool doSort = false}) {
    initData(isDev, doSort);
    var file = File(pubspecDirectory);

    _readYamlMap(file);
    _readPrimaryNode(file);
  }

  void _readPrimaryNode(File file) {
    final lines = file.readAsLinesSync();

    for (var line in lines) {
      if (isKeyNode(line)) {
        nodes.add(KeyNode(line));
      } else if (isEmptyNode(line)) {
        nodes.add(EmptyNode(line));
      } else if (isCommentNode(line)) {
        nodes.add(CommentNode(line));
      }
    }
  }

  void _readYamlMap(File file) {
    yaml = Map.of(
      loadYaml(file.readAsStringSync()).map(
        (key, value) => MapEntry(
          key,
          _getModifiableNode(value),
        ),
      ),
    );
  }

  dynamic _getModifiableNode(node) {
    if (node is Map) {
      return Map.of(node.map((key, value) => MapEntry(key, _getModifiableNode(value))));
    } else if (node is Iterable) {
      return List.of(node.map(_getModifiableNode));
    } else {
      return node;
    }
  }

  bool get containsFlutter => yaml['dependencies'].containsKey('flutter');

  bool isEmptyNode(String line) =>
      line.isEmpty && nodes.isNotEmpty && nodes.last is! EmptyNode;

  bool isCommentNode(String line) => line.startsWith('#');

  bool isSubNode(String line) => line.startsWith(' ') || !line.contains(':');

  bool isKeyNode(String line) =>
      !isEmptyNode(line) && !isCommentNode(line) && !isSubNode(line);

  String showPrimaryNodes() => nodes.map((e) => e.line).toList().join('\n');

  String showYamlObject() => yaml.toString();
}
