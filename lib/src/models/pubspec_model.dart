import 'dart:io';

import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/utils/files/pubspec_file.dart';
import 'package:yaml/yaml.dart';

final environment = 'TEST';

final mainDirectory = environment.isEmpty ? '' : 'filetest';
final pubspecDirectory =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';

class PubSpecModel {
  PubSpecModel._({
    required this.isDev,
    required this.devDependencies,
    required this.dependencies,
  });

  factory PubSpecModel.load(bool isDev) {
    final file = File(pubspecDirectory);
    YamlMap doc = loadYaml(file.readAsStringSync());

    return PubSpecModel._(
      isDev: isDev,
      dependencies: doc['dependencies'] == null ? {} : Map.from(doc['dependencies']),
      devDependencies:
          doc['dev_dependencies'] == null ? {} : Map.from(doc['dev_dependencies']),
    );
  }

  final Map dependencies;
  final Map devDependencies;
  final bool isDev;
  final List<PackageModel> listPackages = [];

  void addToDependencies(List<PackageModel> list) {
    final map = (isDev ? devDependencies : dependencies)
      ..addAll({for (var pkg in list) pkg.name: pkg.version});

    listPackages.addAll(
      map.entries.map((e) => PackageModel(e.key, version: e.value)).toList(),
    );
  }

  void saveFile(bool doSort) {
    saveFileUtil(listPackages, isDev, doSort);
  }

  PubSpecModel copy({
    Map<String, String>? devDependencies,
    Map? dependencies,
    bool? isDev,
  }) {
    return PubSpecModel._(
      devDependencies: devDependencies ?? this.devDependencies,
      dependencies: dependencies ?? this.dependencies,
      isDev: isDev ?? this.isDev,
    );
  }
}
