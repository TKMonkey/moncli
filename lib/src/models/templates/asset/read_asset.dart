import 'dart:io';

import 'package:args/args.dart';
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/pubspec/pubspec.dart';
import 'package:moncli/src/models/templates/asset/asset_file.dart';
import 'package:moncli/src/models/templates/asset/asset_manager.dart';
import 'package:moncli/src/models/templates/i_template.dart';
import 'package:moncli/src/models/yaml/element_validator.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:moncli/src/utils/utils.dart';

class ReadAssets extends YamlModel implements ITemplate {
  ReadAssets.read() {
    final file = File(assetsOutputPath);
    readYamlMap(file);
    getAllElements();
  }

  static const String _folderKey = 'assets_folder';
  static const String _excludeSubFolderKey = 'exclude_subfolders';
  static const String _excludeExtensionTypeKey = 'exclude_extension_type';
  static const String _folderOutputKey = 'folder_output';
  static const String _postFixKey = 'post_fix';
  static const String _preFixKey = 'pre_fix';
  static const String _pubspecStrategyKey = 'pubspec_strategy';
  static const String _nameAssetsClassKey = 'name_assets_class';
  static const String _nameAssetsFileKey = 'name_assets_file';

  late final String assetsFolder;
  late final List excludeSubFolder;
  late final List excludeExtensionType;
  late final String folderOutput;
  late final String postFix;
  late final String preFix;
  late final bool folderStrategy;
  late final String nameAssetsClass;
  late final String nameAssetsFileKey;

  @override
  void getAllElements() {
    assetsFolder = '$mainDirectory$slash${getNodeOrDefaultValue(_folderKey)}';
    excludeSubFolder = getNodeOrDefaultValue<List>(_excludeSubFolderKey);
    excludeExtensionType = getNodeOrDefaultValue<List>(_excludeExtensionTypeKey);
    folderOutput = getNodeOrDefaultValue(_folderOutputKey);
    postFix = getNodeOrDefaultValue(_postFixKey);
    preFix = getNodeOrDefaultValue(_preFixKey);
    folderStrategy = getNodeOrDefaultValue(_pubspecStrategyKey) == 'folder';
    nameAssetsClass = getNodeOrDefaultValue(_nameAssetsClassKey);
    nameAssetsFileKey = getNodeOrDefaultValue(_nameAssetsFileKey);
  }

  @override
  void validateData() {
    validate(validators);
  }

  @override
  void create(ArgResults? argResults) {
    final bool noCreateAssetsManager =
        argResults != null ? argResults['nocreate'] : false;
    final listFiles = readAllAssets();

    final pub = Pubspec.init();
    final assetsFluterNode = pub.getNodeOrDefault<Map>('flutter', {});
    assetsFluterNode['assets'] = getElementsToPub(folderStrategy, listFiles);
    pub
      ..assignNewValueNode('flutter', assetsFluterNode)
      ..saveYaml();

    if (!noCreateAssetsManager) {
      AssetManager(
        name: nameAssetsClass,
        outputName: nameAssetsFileKey,
        outputPath: folderOutput,
        data: listFiles,
      ).write();
    }
  }

  Iterable<AssetsFile> readAllAssets() {
    return getListOfFiles(assetsFolder)
        .map((element) => AssetsFile.init(assetsFolder, element, preFix, postFix))
        .where((af) =>
            !excludeSubFolder.any((element) => af.path.contains(element)) &&
            !excludeExtensionType.any((element) => af.outputPath.contains('.$element')));
  }

  @override
  List<ElementValidator> validators = [
    ElementValidator(key: _folderKey),
    ElementValidator(key: _excludeSubFolderKey, isRequired: false),
    ElementValidator(key: _excludeExtensionTypeKey, isRequired: false),
    ElementValidator(key: _folderOutputKey),
    ElementValidator(key: _postFixKey, isRequired: false),
    ElementValidator(key: _preFixKey, isRequired: false),
    ElementValidator(
      key: _pubspecStrategyKey,
      isRequired: false,
      validValues: [
        'folder',
        'file',
        '',
      ],
    ),
    ElementValidator(key: _nameAssetsClassKey),
    ElementValidator(key: _nameAssetsFileKey),
  ];

  @override
  Map<String, dynamic> defaultValue = {
    _folderKey: '',
    _excludeSubFolderKey: [],
    _excludeExtensionTypeKey: [],
    _folderOutputKey: '',
    _postFixKey: '',
    _preFixKey: '',
    _pubspecStrategyKey: 'folder',
    _nameAssetsClassKey: '',
    _nameAssetsFileKey: '',
  };

  Iterable<String> getElementsToPub(bool isFolder, Iterable<AssetsFile> allElements) {
    return isFolder ? getFolderStrategy(allElements) : getSingleStrategy(allElements);
  }

  Iterable<String> getFolderStrategy(Iterable<AssetsFile> allElements) =>
      allElements.map((e) => e.path).toSet();

  Iterable<String> getSingleStrategy(Iterable<AssetsFile> allElements) =>
      allElements.map((e) => e.outputPath);

  @override
  T getNodeOrDefaultValue<T>(String key) {
    return getNodeOrDefault<T>(key, defaultValue[key]);
  }
}
