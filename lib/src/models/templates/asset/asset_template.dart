import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_node_factory.dart';
import 'package:moncli/src/models/node/i_string_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/templates/template.dart';

/// Abstraction for asset template file.
///
/// This class should be extended for every different format the template is accepted
abstract class AssetTemplate extends Template {
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
  late final Iterable<INode<String>> excludeSubFolder;
  late final Iterable<INode<String>> excludeExtensionType;
  late final String folderOutput;
  late final String postFix;
  late final String preFix;
  late final bool folderStrategy;
  late final String nameAssetsClass;
  late final String nameAssetsFile;

  final INodeFactory _nodeFactory;

  AssetTemplate(this._nodeFactory);

  @override
  Map<String, INode> get defaultValue => {
        _folderKey: _nodeFactory.emptyStringNode,
        _excludeSubFolderKey: _nodeFactory.emptyIIterableNode<String>(),
        _excludeExtensionTypeKey: _nodeFactory.emptyIIterableNode<String>(),
        _folderOutputKey: _nodeFactory.emptyStringNode,
        _postFixKey: _nodeFactory.emptyStringNode,
        _preFixKey: _nodeFactory.emptyStringNode,
        _pubspecStrategyKey: _nodeFactory.createStringNode('folder'),
        _nameAssetsClassKey: _nodeFactory.emptyStringNode,
        _nameAssetsFileKey: _nodeFactory.emptyStringNode,
      };

  @override
  List<NodeValidator> get validators => [
        NodeValidator(key: _folderKey),
        NodeValidator(key: _excludeSubFolderKey, isRequired: false),
        NodeValidator(key: _excludeExtensionTypeKey, isRequired: false),
        NodeValidator(key: _folderOutputKey),
        NodeValidator(key: _postFixKey, isRequired: false),
        NodeValidator(key: _preFixKey, isRequired: false),
        NodeValidator(
          key: _pubspecStrategyKey,
          isRequired: false,
          validValues: [
            'folder',
            'file',
            '',
          ],
        ),
        NodeValidator(key: _nameAssetsClassKey),
        NodeValidator(key: _nameAssetsFileKey),
      ];

  @override
  void readAllNodes() {
    assetsFolder =
        '$mainDirectory$slash${getNodeOrDefaultValue(_folderKey).value}';
    excludeSubFolder =
        getIterableNodeOrDefaultAs<String>(_excludeSubFolderKey).value;
    excludeExtensionType =
        getIterableNodeOrDefaultAs<String>(_excludeExtensionTypeKey).value;
    folderOutput = getNodeOrDefaultValue<IStringNode>(_folderOutputKey).value;
    postFix = getNodeOrDefaultValue<IStringNode>(_postFixKey).value;
    preFix = getNodeOrDefaultValue<IStringNode>(_preFixKey).value;
    folderStrategy =
        getNodeOrDefaultValue<IStringNode>(_pubspecStrategyKey).value ==
            'folder';
    nameAssetsClass =
        getNodeOrDefaultValue<IStringNode>(_nameAssetsClassKey).value;
    nameAssetsFile =
        getNodeOrDefaultValue<IStringNode>(_nameAssetsFileKey).value;
  }
}
