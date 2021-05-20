import 'dart:io';

import 'package:moncli/src/models/moncli_map.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/node/yaml_null_node.dart';
import 'package:yaml/yaml.dart';

import 'mixin_yaml_printer.dart';

/// MoncliMap specialized in Yaml files
class Yaml extends MoncliMap with YamlPrinterMixin {
  Yaml(File file) : super(YamlNullNode()) {
    internalMap = Map.of(
      (loadYaml(file.readAsStringSync()) as Map<dynamic, dynamic>).map(
        (key, value) => MapEntry(
          key as String,
          INode.create(value, YamlNodeFactory.sInstance),
        ),
      ),
    );
  }
}
