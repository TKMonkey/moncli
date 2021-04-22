import 'dart:collection';
import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/base/exceptions/key_no_found_exception.dart';
import 'package:moncli/src/models/yaml/line.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:yaml/yaml.dart';

final mainDependencies = 'dependencies';
final devDependencies = 'dev_dependencies';
mixin PubspecFunctionsMixin {
  final nodes = <Line>[];
  late final bool isDev;
  late final bool doSort;
  late final Map yaml;

  void initData(bool isDev, doSort) {
    this.isDev = isDev;
    this.doSort = doSort;
  }

  void addDependencies(List<PubPackageModel> list) {
    final dependencies = (isDev ? devDependencies : mainDependencies);
    final otherDependencies = (!isDev ? devDependencies : mainDependencies);
    _orderDependenciesStr(dependencies, list);
    _formatOtherDependencies(otherDependencies);
  }

  List<PubPackageModel> removeDependencies(List<PubPackageModel> list) {
    final dependenciesStr = (isDev ? devDependencies : mainDependencies);
    final dependencies = Map.of(
      (yaml[dependenciesStr] ?? {}).map((key, value) => MapEntry(key, value ?? '')),
    );

    final returnValues = <PubPackageModel>[];
    for (final dependency in list) {
      returnValues.add(dependency.copyWith(
        isValid: dependencies.remove(dependency.name) != null,
      ));
    }

    yaml[mainDependencies] = dependencies;

    return returnValues;
  }

  void orderDependencies() {
    _orderDependenciesStr(mainDependencies, []);
    _orderDependenciesStr(devDependencies, []);
  }

  String getScriptFromPubspec(String key) {
    final scripts = yaml['scripts'];
    _noFoundScriptKey(scripts);

    String? command = '';

    if (scripts is String && scripts.contains('.yaml')) {
      final scriptFile = _getScriptFile(scripts);
      command = scriptFile[key];
    } else if (scripts is String) {
      command = scripts;
    } else {
      command = Map.of(scripts)[key];
    }

    if (command == null) {
      _noFoundScript(key);
    }

    return command ?? '';
  }

  Map getDependencies() {
    return Map.of(
      (yaml[mainDependencies] ?? {}).map((key, value) => MapEntry(key, value ?? '')),
    );
  }

  int compareMap(Map map, key1, key2) {
    if (map[key1] is Map) {
      return -1;
    }

    return key1.compareTo(key2);
  }

  void _orderDependenciesStr(String mainDependencies, List<PubPackageModel> list) {
    final dependencies = Map.of(
      (yaml[mainDependencies] ?? {}).map((key, value) => MapEntry(key, value ?? '')),
    )..addAll({for (var pkg in list) pkg.name: pkg.version});

    yaml[mainDependencies] = doSort
        ? SplayTreeMap.from(
            dependencies,
            (key1, key2) => compareMap(
              dependencies,
              key1,
              key2,
            ),
          )
        : dependencies;
  }

  void _formatOtherDependencies(String otherDependencies) {
    final dependencies = Map.of(
      (yaml[otherDependencies] ?? {}).map((key, value) => MapEntry(key, value ?? '')),
    );

    yaml[otherDependencies] = dependencies;
  }

  Map<String, dynamic> _getScriptFile(String scripts) {
    final file = File('$mainDirectory/$scripts');
    return Map.of(loadYaml(file.readAsStringSync()));
  }

  void _noFoundScript(String key) {
    throw FormatException('command $key not found');
  }

  void _noFoundScriptKey(dynamic scripts) {
    if (scripts == null) {
      throw const KeyNoFoundException('scripts');
    }
  }
}
