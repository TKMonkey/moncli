import 'package:dcli/dcli.dart' as dcli;
import 'package:moncli/src/models/yaml_model.dart';

YamlModel readYaml(String path) {
  final lines = dcli.read(path).toList();
  return YamlModel()..readYaml(lines);
}
