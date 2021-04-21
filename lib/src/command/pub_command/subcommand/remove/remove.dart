import 'package:args/args.dart';
import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/models/yaml_model.dart';
import 'package:moncli/src/utils/utils.dart';

Future<bool> remove(ArgResults argResults) async {
  bool isDev = argResults['dev'];

  final packageList =
      argResults.rest.map((pack) => getPackageModel(pack, isDev)).toList();

  final yaml = YamlModel.pubspec(isDev: isDev);

  final packageReturnedList =
      (yaml.removeDependencies(packageList)).splitMatch((pkg) => pkg.isValid);

  yaml.saveYaml();
  removeReport(packageReturnedList);

  return yaml.containsFlutter;
}

PackageModel getPackageModel(String pkgName, bool isDev) {
  return PackageModel(pkgName, isDev: isDev);
}

void removeReport(ListMatch<PackageModel> list) {
  if (list.matched.isNotEmpty) {
    logger.success('> The next packages were removed from pubspec.yaml:');
    for (var pack in list.matched) {
      logger.info('✔ ${pack.name}');
    }
  }

  if (list.unmatched.isNotEmpty) {
    logger
      ..info('')
      ..err('> Package not found in pubspec.yaml:');

    for (var pack in list.unmatched) {
      logger.info('x ${pack.name}');
    }
  }
}
