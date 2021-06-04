import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/i_string_node.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/yaml/line/empty_line.dart';
import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

import 'mixin_pubspec.dart';

const assetsKey = 'assets';
const flutterKey = 'flutter';
const dependenciesKey = 'dependencies';
const devDependenciesKey = 'dev_dependencies';

class Pubspec extends Yaml with PubspecMixin {
  Pubspec.init({this.isDev = false, this.doSort = false})
      : super(File(pubspecFileName)) {
    readPrimaryLines(File(pubspecFileName));
  }

  final lines = <YamlLine>[];
  final bool isDev;
  final bool doSort;

  @override
  void operator []=(String key, INode value) {
    _addToLinesIfNeeded(key, value);
    super[key] = value;
  }

  @override
  void addAll(Map<String, INode> other) {
    for (final entry in other.entries) {
      _addToLinesIfNeeded(entry.key, entry.value);
    }
    super.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<String, INode>> newEntries) {
    for (final entry in newEntries) {
      _addToLinesIfNeeded(entry.key, entry.value);
    }
    internalMap.addEntries(newEntries);
  }

  @override
  INode putIfAbsent(String key, INode Function() ifAbsent) {
    if (this[key] is! INullNode) {
      return this[key];
    }

    //Calling ifAbsent and caching value to prevent it from being called more than once
    final ifAbsentValue = ifAbsent();

    _addToLinesIfNeeded(key, ifAbsentValue);

    //Create new ifAbsent function to return cached value instead of calling original ifAbsent again
    return super.putIfAbsent(key, () => ifAbsentValue);
  }

  void readPrimaryLines(File file) {
    final linesFile = file.readAsLinesSync();

    for (final line in linesFile) {
      final newLine = YamlLine.create(line);
      if (newLine != null) {
        lines.add(newLine);
      }
    }
  }

  void saveYaml() {
    toYamlString(this, lines);
  }

  void addDependencies(List<PubPackageModel> list) {
    orderDependencies(list: list);
  }

  List<PubPackageModel> removeDependencies(List<PubPackageModel> list) {
    final key = isDev ? devDependenciesKey : dependenciesKey;
    final dep = formatDependencies(this[key]);

    final returnValues = <PubPackageModel>[];
    for (final dependency in list) {
      returnValues.add(
        dependency.copyWith(
          isValid: dep.value.remove(dependency.name) != null,
        ),
      );
    }

    this[key] = dep;

    return returnValues;
  }

  void orderDependencies({List<PubPackageModel> list = const []}) {
    final devDependencies = orderDependenciesMap(
      devDependenciesKey,
      getNodeAs<IMapNode>(devDependenciesKey)!,
      list: list,
      sort: doSort,
    );

    final dependencies = orderDependenciesMap(
      dependenciesKey,
      getNodeAs<IMapNode>(dependenciesKey)!,
      list: list,
      sort: doSort,
    );

    this[devDependenciesKey] =
        INode.create(devDependencies, YamlNodeFactory.sInstance);

    this[dependenciesKey] =
        INode.create(dependencies, YamlNodeFactory.sInstance);
  }

  String getScriptFromPubspec(String key) {
    final scripts = getNodeOrException(key);
    String? command;
    //TODO: Understand and check this
    if (scripts is IStringNode && scripts.value.contains('.yaml')) {
      final scriptFile = _getScriptFile(scripts.value);
      command = scriptFile[key] as String?;
    } else if (scripts is IStringNode) {
      command = scripts.value;
    } else if (scripts is IMapNode) {
      command = (scripts.value[key]! as IStringNode).value;
    }

    if (command == null) {
      throw FormatException('command $key not found');
    }

    return command;
  }

  IMapNode getDependencies() =>
      formatDependencies(getNodeAs<IMapNode>(dependenciesKey));

  bool get containsFlutterKey =>
      getNodeOrDefault(dependenciesKey, YamlNodeFactory.sInstance.emptyIMapNode)
          .value
          .containsKey(flutterKey);

  bool get containsAssetsKey =>
      getNodeOrDefault(flutterKey, YamlNodeFactory.sInstance.emptyIMapNode)
          .value
          .containsKey(assetsKey);

  Map<String, dynamic> _getScriptFile(String scriptsFile) {
    final path = '$mainDirectory$slash$scriptsFile';

    final file = File(path);
    return Map.of(loadYaml(file.readAsStringSync()) as Map<String, dynamic>);
  }

  /// Adds new line to lines if key is not currently in the yaml file
  void _addToLinesIfNeeded(String key, INode value) {
    if (this[key] is! INullNode) {
      return;
    }

    final newLine = YamlLine.create('$key:');

    if (newLine == null) {
      return;
    }

    lines..add(const EmptyLine())..add(newLine);
  }
}
