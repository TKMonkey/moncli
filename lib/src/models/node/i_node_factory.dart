import 'package:moncli/src/models/node/i_bool_node.dart';
import 'package:moncli/src/models/node/i_double_node.dart';
import 'package:moncli/src/models/node/i_dynamic_node.dart';
import 'package:moncli/src/models/node/i_int_node.dart';
import 'package:moncli/src/models/node/i_iterable_node.dart';
import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/i_string_node.dart';

abstract class INodeFactory {
  IMapNode get emptyIMapNode;

  IIterableNode<T> emptyIIterableNode<T>();

  IStringNode get emptyStringNode;

  IMapNode createMapNode(Map node);

  IIterableNode<T> createIterableNode<T>(Iterable<T> node);

  IStringNode createStringNode(String node);

  IIntNode createIntNode(int node);

  IDoubleNode createDoubleNode(double node);

  IBoolNode createBoolNode(bool node);

  INullNode createNullNode();

  IDynamicNode createDynamicNode(dynamic node);
}
