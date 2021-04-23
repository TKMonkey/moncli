import 'dart:io';

import 'package:args/args.dart';
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
    validate(validators);
  }

  @override
  void create(ArgResults? argResults) {
    bool noCreateAssetsManager = argResults != null ? argResults['nocreate'] : false;
  }

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
