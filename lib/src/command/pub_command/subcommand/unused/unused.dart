import 'package:args/args.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/pubspec/pubspec.dart';
import 'package:moncli/src/utils/utils.dart';

Future<bool> unused(ArgResults argResults) async {
  final bool remove = argResults['remove'];

  final yaml = Pubspec.init();

  final dependencies = yaml.getDependencies();
  final listUnused = <PubPackageModel>[];

  for (final name in dependencies.value.keys) {
    if (name == 'flutter') {
      continue;
    }

    final isUsingPackage = isUsedInProject(name);
    if (!isUsingPackage) {
      //TODO: Check dependencies.value[name]!.value os w'rmoeg as expected
      listUnused
          .add(PubPackageModel(name, version: dependencies.value[name]!.value));
    }
  }

  if (remove) {
    yaml
      ..removeDependencies(listUnused)
      ..saveYaml();
  }

  unusedReport(listUnused);

  return yaml.containsFlutterKey;
}

void unusedReport(List<PubPackageModel> list) {
  if (list.isNotEmpty) {
    logger.alert("> The next packages don't have any use in the project:");
    for (final pack in list) {
      logger.info('- ${pack.name}: ${pack.version}');
    }
  }
}
