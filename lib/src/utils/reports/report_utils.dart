import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/utils/utils.dart';

void installReport(ListMatch<PackageModel> list) {
  if (list.matched.isNotEmpty) {
    logger.success('* The next packages were added in pubspec.yaml:');
    for (var pack in list.matched) {
      logger.info('✔ ${pack.name}: ${pack.version}');
    }
  }

  if (list.unmatched.isNotEmpty) {
    logger
      ..info('')
      ..err('x Package not found:');

    for (var pack in list.unmatched) {
      logger.info('x ${pack.name}');
    }
  }
}
