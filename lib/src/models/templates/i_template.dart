import 'package:args/args.dart';
import 'package:moncli/src/models/yaml/element_validator.dart';

abstract class ITemplate {
  void getAllElements();
  void validateData();
  void create(ArgResults? argResults);

  late final List<ElementValidator> validators;
  late final Map<String, dynamic> defaultValue;
  T getNodeOrDefaultValue<T>(String key);
}
