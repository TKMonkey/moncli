import 'dart:collection';

import 'package:moncli/src/models/node_model.dart';
import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/utils/files/yaml_util.dart';

abstract class YamlFunctions {
  final nodes = <Node>[];
  late final bool isDev;
  late final bool doSort;
  late final Map yaml;

  void initData(bool isDev, doSort) {
    this.isDev = isDev;
    this.doSort = doSort;
  }

  void addDependencies(List<PackageModel> list) {
    final mainDependencies = (isDev ? 'dev_dependencies' : 'dependencies');
    final otherDependencies = (!isDev ? 'dev_dependencies' : 'dependencies');
    _orderDependenciesStr(mainDependencies, list);
    _orderOtherDependencies(otherDependencies);
  }

  List<PackageModel> removeDependencies(List<PackageModel> list) {
    final mainDependencies = (isDev ? 'dev_dependencies' : 'dependencies');
    final dependencies = Map.of(
      (yaml[mainDependencies] ?? {}).map((key, value) => MapEntry(key, value ?? '')),
    );

    final returnValues = <PackageModel>[];
    for (final dependency in list) {
      returnValues.add(dependency.copyWith(
        isValid: dependencies.remove(dependency.name) != null,
      ));
    }

    yaml[mainDependencies] = dependencies;

    return returnValues;
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

  void _orderDependenciesStr(String mainDependencies, List<PackageModel> list) {
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

  void _orderOtherDependencies(String otherDependencies) {
    final dependencies = Map.of(
      (yaml[otherDependencies] ?? {}).map((key, value) => MapEntry(key, value ?? '')),
    );

    yaml[otherDependencies] = dependencies;
  }
}
