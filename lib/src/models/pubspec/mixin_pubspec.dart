import 'dart:collection';

import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/yaml/line.dart';

mixin PubspecMixin {
  bool isEmptyNode(String lineStr, List<Line> lines) =>
      lineStr.isEmpty && lines.isNotEmpty && lines.last is! EmptyLine;

  bool isCommentNode(String lineStr) => lineStr.startsWith('#');

  bool isSubNode(String lineStr) => lineStr.startsWith(' ') || !lineStr.contains(':');

  bool isKeyNode(String lineStr, List<Line> lines) =>
      !isEmptyNode(lineStr, lines) && !isCommentNode(lineStr) && !isSubNode(lineStr);

  Map orderDependenciesMap(
    String key,
    Map initialMap, {
    List<PubPackageModel> list = const [],
    bool sort = false,
  }) {
    final dependencies = formatDependecies(initialMap)
      ..addAll({for (var pkg in list) pkg.name: pkg.version});

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

  Map formatDependecies(Map initialMap) {
    return Map.of(
      initialMap.map(
        (key, value) => MapEntry(key, value ?? ''),
      ),
    );
  }

  int compareMap(Map map, key1, key2) {
    if (map[key1] is Map) {
      return -1;
    }

    return key1.compareTo(key2);
  }
}
