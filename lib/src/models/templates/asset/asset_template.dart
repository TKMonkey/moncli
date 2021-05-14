import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/yaml/element_validator.dart';

import '../i_template.dart';

abstract class AssetTemplate implements ITemplate {
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
  late final String nameAssetsFile;

  AssetTemplate(String sourceFilePath) {
    readFile(sourceFilePath);
    readAllElements();
    validate();
  }

  @override
  Map<String, dynamic> get defaultValue => {
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

  @override
  List<ElementValidator> get validators => [
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
  void readAllElements() {
    assetsFolder = '$mainDirectory$slash${getNodeOrDefaultValue(_folderKey)}';
    excludeSubFolder = getNodeOrDefaultValue<List>(_excludeSubFolderKey);
    excludeExtensionType =
        getNodeOrDefaultValue<List>(_excludeExtensionTypeKey);
    folderOutput = getNodeOrDefaultValue(_folderOutputKey);
    postFix = getNodeOrDefaultValue(_postFixKey);
    preFix = getNodeOrDefaultValue(_preFixKey);
    folderStrategy = getNodeOrDefaultValue(_pubspecStrategyKey) == 'folder';
    nameAssetsClass = getNodeOrDefaultValue(_nameAssetsClassKey);
    nameAssetsFile = getNodeOrDefaultValue(_nameAssetsFileKey);
  }
}
