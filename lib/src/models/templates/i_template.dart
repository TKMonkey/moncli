import 'package:moncli/src/models/yaml/element_validator.dart';

abstract class ITemplate {
  void validateData();
  void create();

  late final List<ElementValidator> validators;
  late final Map<String, dynamic> defaultValue;
}
