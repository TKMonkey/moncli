import 'dart:io';
import 'package:moncli/src/base/exceptions/exceptions.dart';
import 'package:moncli/src/utils/utils.dart';
import 'package:yaml/yaml.dart';
import 'element_validator.dart';
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

  T? getNode<T>(String key) {
    return yaml[key];
  }

  T getNodeOrDefault<T>(String key, T defaultValue) {
    return yaml[key] ?? defaultValue;
  }

  dynamic getNodeOrException(String key, {String? fileName}) {
    final value = yaml[key];
    if (value == null) {
      throw KeyNoFoundException(key, fileName: fileName);
    }

    return value;
  }

  void assignNewValueNode(String key, dynamic value) {
    yaml[key] = value;
  }

  void validate(List<ElementValidator> validators) {
    final filter = validators
        .map((validator) => validator..setValidator(yaml[validator.key]))
        .where((element) => !element.isValid)
        .toList()
        .asMap()
        .map((key, validator) => MapEntry(validator.key, validator.reason));

    reportErrorsValidator(filter);
  }

  dynamic _getModifiableNode(node) {
    if (node is Map) {
      return Map.of(node.map((key, value) => MapEntry(key, _getModifiableNode(value))));
    } else if (node is Iterable) {
      return List.of(node.map(_getModifiableNode));
    } else {
      return node;
    }
  }

  void reportErrorsValidator(Map<String, String> validateMap) {
    if (validateMap.isNotEmpty) {
      logger.err('Errors with validators');
      for (final element in validateMap.entries) {
        logger.info('${yellow(element.key)}: ${element.value}');
      }

      throw const ValidatorsException();
    }
  }
}
