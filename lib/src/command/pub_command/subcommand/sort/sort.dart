import 'package:moncli/src/models/pubspec/pubspec_model.dart';

Future<bool> order() async {
  final yaml = Pubspec.init(doSort: true)
    ..orderDependencies()
    ..saveYaml();

  return yaml.containsFlutterKey;
}
