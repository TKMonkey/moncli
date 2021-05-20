import 'package:meta/meta.dart';
import 'package:moncli/src/models/node/i_iterable_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

/// Abstracts a template file.
///
/// It defines general methods to allow creating a representation of a template
/// file [in any format] into memory that can be processed afterwards
abstract class ITemplate {
  @protected
  List<NodeValidator> get validators;

  @protected
  Map<String, INode> get defaultValue;

  @protected
  void readAllNodes();

  @protected
  T getNodeOrDefaultValue<T extends INode>(String key);

  @protected
  IIterableNode<T> getIterableNodeOrDefaultAs<T>(String key);

  @protected
  void validate();
}
