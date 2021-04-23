import 'package:args/args.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/pubspec/pubspec_model.dart';
import 'package:moncli/src/utils/utils.dart';

Future<bool> unused(ArgResults argResults) async {
  bool remove = argResults['remove'];

  final yaml = Pubspec.init();

  final dependencies = yaml.getDependencies();
  final listUnused = <PubPackageModel>[];

  for (var name in dependencies.keys) {
    if (name == 'flutter') {
      continue;
    }

    final isUsingPackage = isUsedInProject(name);
    if (!isUsingPackage) {
      listUnused.add(PubPackageModel(name, version: dependencies[name]));
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
    logger.alert('> The next packages don\'t have any use in the project:');
    for (var pack in list) {
      logger.info('- ${pack.name}: ${pack.version}');
    }
  }
}
