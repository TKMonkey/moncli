import 'dart:io';

import 'package:moncli/src/base/exceptions/validators_exception.dart';
import 'package:moncli/src/models/node/i_iterable_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/templates/asset/asset_template.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:moncli/src/utils/utils.dart';

/// Yaml abstraction for Asset Template
class YamlAssetTemplate extends AssetTemplate {
  final Yaml _yaml;

  YamlAssetTemplate(String sourceFilePath)
      : _yaml = Yaml(File(sourceFilePath)),
        super(YamlNodeFactory.sInstance);

  @override
  T getNodeOrDefaultValue<T extends INode>(String key) {
    return _yaml.getNodeOrDefault<T>(key, defaultValue[key]! as T);
  }

  @override
  IIterableNode<T> getIterableNodeOrDefaultAs<T>(String key) =>
      getNodeOrDefaultValue<IIterableNode>(key).castTo<T>();

  @override
  void validate() {
    final validation = _yaml.getValidation(validators);

    if (validation.isNotEmpty) {
      logger.reportNodeValidators(validation);
      throw const ValidatorsException();
    }
  }
}
