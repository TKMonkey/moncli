import 'package:moncli/src/models/yaml/yaml_model.dart';

Future<bool> order() async {
  final yaml = YamlModel.pubspec(doSort: true)
    ..orderDependencies()
    ..saveYaml();

  return yaml.containsFlutter;
}
