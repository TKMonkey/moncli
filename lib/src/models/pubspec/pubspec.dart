import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_string_node.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:yaml/yaml.dart';

import 'mixin_pubspec.dart';

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

  void readPrimaryLines(File file) {
    final linesFile = file.readAsLinesSync();

    for (final line in linesFile) {
      final newLine = YamlLine.create(line, lines);
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
      command = scriptFile[key];
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
      getNodeOrDefault('dependencies', YamlNodeFactory.sInstance.emptyIMapNode)
          .value
          .containsKey('flutter');

  bool get containsAssetsKey =>
      getNodeOrDefault('flutter', YamlNodeFactory.sInstance.emptyIMapNode)
          .value
          .containsKey('assets');

  Map<String, dynamic> _getScriptFile(String scriptsFile) {
    final path = '$mainDirectory$slash$scriptsFile';

    final file = File(path);
    return Map.of(loadYaml(file.readAsStringSync()));
  }
}
