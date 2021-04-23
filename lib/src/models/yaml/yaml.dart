import 'dart:io';
import 'package:moncli/src/base/exceptions/exceptions.dart';
import 'package:yaml/yaml.dart';
import 'element_validator.dart';
import 'line.dart';
import 'mixin_yaml_printer.dart';

abstract class YamlModel with YamlPrinterMixin {
  late final Map yaml;

  void readYamlMap(File file) {
    yaml = Map.of(
      loadYaml(file.readAsStringSync()).map(
        (key, value) => MapEntry(
          key,
          _getModifiableNode(value),
        ),
      ),
    );
  }

  void saveYaml(List<Line> lines) {
    toYamlString(yaml, lines);
  }

  dynamic? getNode(String key) {
    return yaml[key];
  }

  dynamic getNodeException(String key, {String? fileName}) {
    final value = yaml[key];
    if (value == null) {
      throw KeyNoFoundException(key, fileName: fileName);
    }

    return value;
  }

  Map<String, String> validate(List<ElementValidator> validators) {
    for (var validator in validators) {
      validator.setValidator(yaml[validator.key]);
    }

    return {
      for (var validator in validators.where((element) => !element.isValid))
        validator.key: validator.reason
    };
  }

  dynamic _getModifiableNode(node) {
    if (node is Map) {
      return Map.of(node.map((key, value) => MapEntry(key, _getModifiableNode(value))));
    } else if (node is Iterable) {
      return List.of(node.map(_getModifiableNode));
    } else {
      return node ?? '';
    }
  }
}
