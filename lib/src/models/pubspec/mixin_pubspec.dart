import 'dart:collection';

import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';

mixin PubspecMixin {
  Map<String, INode> orderDependenciesMap(
    String key,
    IMapNode initialMap, {
    List<PubPackageModel> list = const [],
    bool sort = false,
  }) {
    final dependencies = initialMap.value
      ..addAll({
        for (var pkg in list)
          pkg.name: INode.create(pkg.version, YamlNodeFactory.sInstance)
      });

    return sort
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

  IMapNode formatDependencies(INode? initialMap) {
    return (initialMap != null)
        ? initialMap is IMapNode
            ? initialMap
            : YamlNodeFactory.sInstance.emptyIMapNode
        : YamlNodeFactory.sInstance.emptyIMapNode;
  }

  int compareMap(Map map, dynamic key1, dynamic key2) {
    if (map[key1] is Map) {
      return -1;
    }

    return key1.compareTo(key2);
  }
}
