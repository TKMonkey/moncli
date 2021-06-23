import 'package:moncli/src/models/node/i_node_factory.dart';
import 'package:moncli/src/models/node/node_validator.dart';

abstract class INode<T> {
  T get value;

  String toSerializedString(int currentIndentation, bool isTopLevel);

  NodeValidator validate(NodeValidator elementValidator);

  static INode create(dynamic data, INodeFactory factory) {
    if (data is INode) {
      return data;
    }

    if (data is Map) {
      return factory.createMapNode(data);
    } else if (data is Iterable) {
      return factory.createIterableNode(data);
    } else if (data is String) {
      return factory.createStringNode(data);
    } else if (data is int) {
      return factory.createIntNode(data);
    } else if (data is double) {
      return factory.createDoubleNode(data);
    } else if (data is bool) {
      return factory.createBoolNode(data);
    } else if (data == null) {
      return factory.createNullNode();
    }
    return factory.createDynamicNode(data);
  }
}
