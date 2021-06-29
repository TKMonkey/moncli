import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_string_node.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

import 'mixin_pubspec.dart';

const assetsKey = 'assets';
const flutterKey = 'flutter';
const dependenciesKey = 'dependencies';
const devDependenciesKey = 'dev_dependencies';

class Pubspec extends Yaml with PubspecMixin {
  Pubspec._(
      {bool isDev = false,
      bool doSort = false,
      required Map<String, INode> internalMap,
      required List<String> fileLines})
      : _isDev = isDev,
        _doSort = doSort,
        super(internalMap: internalMap, fileLines: fileLines);

  factory Pubspec.create(
      {bool isDev = false,
      bool doSort = false,
      required String yamlString,
      required List<String> fileLines}) {
    final internalMap = Yaml.loadYamlMap(yamlString);

    return Pubspec._(
        isDev: isDev,
        doSort: doSort,
        internalMap: internalMap,
        fileLines: fileLines);
  }

  factory Pubspec.init({bool isDev = false, bool doSort = false}) {
    final file = File(pubspecFileName);
    return Pubspec.create(
        isDev: isDev,
        doSort: doSort,
        yamlString: file.readAsStringSync(),
        fileLines: file.readAsLinesSync());
  }

  final bool _isDev;
  final bool _doSort;

  bool get containsFlutterKey =>
      getNodeOrDefault(dependenciesKey, YamlNodeFactory.sInstance.emptyIMapNode)
          .value
          .containsKey(flutterKey);

  bool get containsAssetsKey =>
      getNodeOrDefault(flutterKey, YamlNodeFactory.sInstance.emptyIMapNode)
          .value
          .containsKey(assetsKey);

  void saveYaml() {
    saveIntoFile(PathConstants().outputPubPath);
  }

  void addDependencies(List<PubPackageModel> list) {
    orderDependencies(list: list);
  }

  List<PubPackageModel> removeDependencies(List<PubPackageModel> list) {
    final key = _isDev ? devDependenciesKey : dependenciesKey;
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
      sort: _doSort,
    );

    final dependencies = orderDependenciesMap(
      dependenciesKey,
      getNodeAs<IMapNode>(dependenciesKey)!,
      list: list,
      sort: _doSort,
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

  Map<String, dynamic> _getScriptFile(String scriptsFile) {
    final path = '$mainDirectory$slash$scriptsFile';

    final file = File(path);
    return Map.of(loadYaml(file.readAsStringSync()) as Map<String, dynamic>);
  }
}
