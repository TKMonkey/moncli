import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/yaml/line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:yaml/yaml.dart';

import 'mixin_pubspec.dart';

final dependenciesKey = 'dependencies';
final devDependenciesKey = 'dev_dependencies';

class Pubspec extends YamlModel with PubspecMixin {
  Pubspec.init({this.isDev = false, this.doSort = false}) {
    var file = File(pubspecFileName);
    readYamlMap(file);
  }

  final lines = <Line>[];
  final bool isDev;
  final bool doSort;

  void readPrimaryLines(File file) {
    final linesFile = file.readAsLinesSync();

    for (var line in linesFile) {
      if (isKeyNode(line, lines)) {
        lines.add(KeyLine(line));
      } else if (isEmptyNode(line, lines)) {
        lines.add(EmptyLine(line));
      } else if (isCommentNode(line)) {
        lines.add(CommentLine(line));
      }
    }
  }

  void saveYaml() {
    toYamlString(yaml, lines);
  }

  void addDependencies(List<PubPackageModel> list) {
    orderDependencies(list: list);
  }

  List<PubPackageModel> removeDependencies(List<PubPackageModel> list) {
    final key = isDev ? devDependenciesKey : dependenciesKey;
    final dep = formatDependecies(getNode(key));

    final returnValues = <PubPackageModel>[];
    for (final dependency in list)
      returnValues.add(
        dependency.copyWith(
          isValid: dep.remove(dependency.name) != null,
        ),
      );

    assignNewValueNode(key, dep);

    return returnValues;
  }

  void orderDependencies({List<PubPackageModel> list = const []}) {
    final devDependencies = orderDependenciesMap(
      devDependenciesKey,
      getNode(devDependenciesKey),
      list: list,
      sort: doSort,
    );

    final dependencies = orderDependenciesMap(
      dependenciesKey,
      getNode(dependenciesKey),
      list: list,
      sort: doSort,
    );

    assignNewValueNode(devDependenciesKey, devDependencies);
    assignNewValueNode(dependenciesKey, dependencies);
  }

  String getScriptFromPubspec(String key) {
    final scripts = getNodeException(key);
    var command = '';

    if (scripts is String && scripts.contains('.yaml')) {
      final scriptFile = _getScriptFile(scripts);
      command = scriptFile[key];
    } else if (scripts is String) {
      command = scripts;
    } else {
      command = Map.of(scripts)[key];
    }

    if (command == null) {
      throw FormatException('command $key not found');
    }

    return command;
  }

  Map getDependencies() => formatDependecies(getNode(dependenciesKey));

  bool get containsFlutterKey => getNode('dependencies').containsKey('flutter');

  bool get containsAssetsKey => getNode('flutter').containsKey('assets');

  Map<String, dynamic> _getScriptFile(String scriptsFile) {
    final path = '$mainDirectory$slash$scriptsFile';

    final file = File(path);
    return Map.of(loadYaml(file.readAsStringSync()));
  }
}
