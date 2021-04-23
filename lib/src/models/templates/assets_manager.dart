import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/templates/i_template.dart';
import 'package:moncli/src/models/yaml/element_validator.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

class AssetManager extends YamlModel implements ITemplate {
  AssetManager.read() {
    var file = File(assetsOutputPath);
    readYamlMap(file);
  }

  @override
  void validateData() {
    final response = validate(validators);
    print(response);
  }

  @override
  void create() {}

  @override
  List<ElementValidator> validators = [
    ElementValidator(key: 'assets_folder'),
    ElementValidator(key: 'folder_output'),
    ElementValidator(key: 'post_fix', isRequired: false),
    ElementValidator(key: 'pre_fix', isRequired: false),
    ElementValidator(
      key: 'pubspec_strategy',
      isRequired: false,
      validValues: [
        'folder',
        'file',
        'default',
        '',
      ],
    ),
    ElementValidator(key: 'name_assets_class'),
    ElementValidator(key: 'name_assets_file'),
  ];

  @override
  Map<String, dynamic> defaultValue = {
    'pubspec_strategy': '',
  };
}
