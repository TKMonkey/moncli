import 'dart:collection';
import 'dart:io';

import 'package:dcli/dcli.dart' show PubSpec;
import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/models/pubspec_model.dart';
import 'package:pubspec/pubspec.dart' show HostedReference;

void addToDependenciesUtil(PubSpec pub, List<PackageModel> list, bool isDev) {
  final packages = {
    for (var pkg in list) pkg.name: HostedReference.fromJson(pkg.version)
  };

  if (isDev) {
    pub.pubspec.devDependencies.addAll(packages);
  } else {
    pub.pubspec.dependencies.addAll(packages);
  }
}

void saveFileUtil(List<PackageModel> list, bool isDev, bool doSort) {
  var yaml = File(pubspecDirectory);
  var node = yaml.readAsLinesSync();
  var isAlter = false;

  var indexDependency = isDev
      ? node.indexWhere((t) => t.contains('dev_dependencies:')) + 1
      : node.indexWhere((t) => t.contains('dependencies:')) + 1;

  if (doSort) {
    list.sort((a, b) => a.name.compareTo(b.name));
  }

  //delete package
  var endDependecies = -1;
  print('dev_dependencies ${indexDependency}');
  print('dev_dependencies ${node.length}');
  for (var i = indexDependency; i < node.length; i++) {
    print(node[i]);
    if (i + 1 == node.length || node[i + 1].isEmpty) {
      endDependecies = i;
    }
  }
  print('dev_dependencies $endDependecies');
  node.removeRange(indexDependency, endDependecies);

  for (var i = 0; i < list.length; i++) {
    node.insert(indexDependency + i, '  ${list[i].name}: ${list[i].version}');
  }

  if (!isAlter) {
    yaml.writeAsStringSync(node.join('\n'));
  }
}
