import 'package:meta/meta.dart';
import 'package:moncli/src/models/yaml/element_validator.dart';

/// Abstracts a template file.
///
/// It defines general methods to allow creating a representation of a template
/// file [in any format] into memory that can be processed afterwards
abstract class ITemplate {
  @protected
  List<ElementValidator> get validators;

  @protected
  Map<String, dynamic> get defaultValue;

  @protected
  void readAllElements();

  @protected
  T getNodeOrDefaultValue<T>(String key);

  @protected
  void readFile(String sourceFilePath);

  @protected
  void validate();
}
