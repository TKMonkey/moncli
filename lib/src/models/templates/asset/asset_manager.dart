import 'dart:io';

import 'package:args/args.dart';
import 'package:dcli/dcli.dart' as dcli;
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/templates/asset/asset_file.dart';
import 'package:moncli/src/models/templates/i_template.dart';
import 'package:moncli/src/models/yaml/element_validator.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:moncli/src/utils/utils.dart';

class AssetManager extends YamlModel implements ITemplate {
  AssetManager.read() {
    final file = File(assetsOutputPath);
    readYamlMap(file);
  }

  static const String _folderKey = 'assets_folder';
  static const String _excludeSubFolderKey = 'exclude_subfolders';
  static const String _excludeExtensionTypeKey = 'exclude_extension_type';

  late final String assetsFolder;
  late final List excludeSubFolder;
  late final List excludeExtensionType;

  @override
  void getAllElements() {
    assetsFolder = '$mainDirectory$slash${getNode<String>(_folderKey, '')}';
    excludeSubFolder = getNode<List>(_excludeSubFolderKey, []);
    excludeExtensionType = getNode<List>(_excludeExtensionTypeKey, []);
  }

  @override
  void validateData() {
    validate(validators);
  }

  @override
  void create(ArgResults? argResults) {
    bool noCreateAssetsManager = argResults != null ? argResults['nocreate'] : false;

    final listFiles = getListOfFiles(assetsFolder)
        .map((e) => AssetsFile.init(assetsFolder, e))
        .where((af) =>
            !excludeSubFolder.any((element) => af.parentFolder.contains(element)) &&
            !excludeExtensionType.any((element) => af.type == element));

    listFiles.forEach((element) {
      print(element.toString());
    });

    //final pub = Pubspec.init();
  }

  void readAllAssets() {}

  @override
  List<ElementValidator> validators = [
    ElementValidator(key: _folderKey),
    ElementValidator(key: _excludeSubFolderKey, isRequired: false),
    ElementValidator(key: _excludeSubFolderKey, isRequired: false),
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
