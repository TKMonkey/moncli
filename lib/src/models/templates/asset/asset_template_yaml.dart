import 'dart:io';

import 'package:moncli/src/models/templates/asset/asset_template.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

class AssetTemplateYaml extends AssetTemplate {
  final YamlModel _yamlModel;

  AssetTemplateYaml(String sourceFilePath)
      : _yamlModel = YamlModel(),
        super(sourceFilePath);

  @override
  T getNodeOrDefaultValue<T>(String key) {
    return _yamlModel.getNodeOrDefault(key, defaultValue[key]);
  }

  @override
  void readFile(String sourceFilePath) {
    final file = File(sourceFilePath);
    _yamlModel.readYamlMap(file);
  }

  @override
  void validate() {
    _yamlModel.validate(validators);
  }
}
