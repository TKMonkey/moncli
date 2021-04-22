import 'package:args/args.dart';
import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/models/pubspec/pubspec_model.dart';
import 'package:moncli/src/utils/utils.dart';

Future<bool> remove(ArgResults argResults) async {
  bool isDev = argResults['dev'];
  final yaml = Pubspec.init(isDev: isDev);

  final packageList = argResults.rest.map((pack) => PackageModel(pack)).toList();

  final packageReturnedList =
      (yaml.removeDependencies(packageList)).splitMatch((pkg) => pkg.isValid);

  yaml.saveYaml();
  removeReport(packageReturnedList);

  return yaml.containsFlutter;
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
