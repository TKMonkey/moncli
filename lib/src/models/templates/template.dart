import 'i_template.dart';

/// Abstracts a template file.
///
/// Shortcut for calling readAllElements() and validate() in constructor
abstract class Template implements ITemplate {
  Template() {
    readAllNodes();
    validate();
  }
}
