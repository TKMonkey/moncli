import 'dart:collection';
import 'dart:io';

import 'package:moncli/src/utils/files/yaml_util.dart';
import 'package:yaml/yaml.dart';

import 'node_model.dart';
import 'package_model.dart';

final environment = 'TEST';

final mainDirectory = environment.isEmpty ? '' : 'filetest';
final pubspecDirectory =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';

final outputDirectory =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec-output.yaml';

class YamlModel {
  YamlModel.pubspec(this.isDev, this.doSort) {
    var file = File(pubspecDirectory);

    _readYamlMap(file);
    _readPrimaryNode(file);
  }

  final nodes = <Node>[];
  final bool isDev;
  final bool doSort;
  late final Map yaml;

  void addDependencies(List<PackageModel> list) {
    final dependenciesStr = (isDev ? 'dev_dependencies' : 'dependencies');
    final otherStr = (!isDev ? 'dev_dependencies' : 'dependencies');

    final dependencies = Map.of(
      (yaml[dependenciesStr] ?? {}).map((key, value) => MapEntry(key, value ?? '')),
    )..addAll({for (var pkg in list) pkg.name: pkg.version});

    yaml[dependenciesStr] = doSort
        ? SplayTreeMap.from(
            dependencies,
            (key1, key2) => compareMap(
              dependencies,
              key1,
              key2,
            ),
          )
        : dependencies;

    final otherDependencies = Map.of(
      (yaml[otherStr] ?? {}).map((key, value) => MapEntry(key, value ?? '')),
    );

    yaml[otherStr] = otherDependencies;
  }

  void saveYaml() {
    toYamlString(yaml, nodes);
  }

  int compareMap(Map map, key1, key2) {
    if (map[key1] is Map) {
      return -1;
    }

    return key1.compareTo(key2);
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

  bool isEmptyNode(String line) =>
      line.isEmpty && nodes.isNotEmpty && nodes.last is! EmptyNode;

  bool isCommentNode(String line) => line.startsWith('#');

  bool isSubNode(String line) => line.startsWith(' ') || !line.contains(':');

  bool isKeyNode(String line) =>
      !isEmptyNode(line) && !isCommentNode(line) && !isSubNode(line);

  String showPrimaryNodes() => nodes.map((e) => e.line).toList().join('\n');

  String showYamlObject() => yaml.toString();
}
