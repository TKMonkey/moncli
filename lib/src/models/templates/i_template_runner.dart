import 'i_template.dart';

/// Abstraction to allow getting an [ITemplate] and creating a new file from it
abstract class ITemplateRunner<T extends ITemplate, C> {
  /// Creates a new file from an [ITemplate].
  ///
  /// It can receive custom [params] to further customize the implementation.
  void call(T template, C params);
}
