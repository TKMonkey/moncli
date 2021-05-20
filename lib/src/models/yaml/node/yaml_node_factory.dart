import 'package:moncli/src/models/node/i_bool_node.dart';
import 'package:moncli/src/models/node/i_double_node.dart';
import 'package:moncli/src/models/node/i_dynamic_node.dart';
import 'package:moncli/src/models/node/i_int_node.dart';
import 'package:moncli/src/models/node/i_iterable_node.dart';
import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_node_factory.dart';
import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/i_string_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_bool_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_double_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_dynamic_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_int_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_iterable_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_map_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_null_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_string_node.dart';

class YamlNodeFactory implements INodeFactory {
  static const sInstance = YamlNodeFactory();

  @override
  IIterableNode<T> emptyIIterableNode<T>() => YamlIterableNode.sEmpty<T>();

  @override
  IMapNode get emptyIMapNode => YamlMapNode.sEmpty;

  @override
  IStringNode get emptyStringNode => YamlStringNode.sEmpty;

  const YamlNodeFactory();

  @override
  IBoolNode createBoolNode(bool node) {
    return YamlBoolNode(node);
  }

  @override
  IDoubleNode createDoubleNode(double node) {
    return YamlDoubleNode(node);
  }

  @override
  IDynamicNode createDynamicNode(node) {
    return YamlDynamicNode(node);
  }

  @override
  IIntNode createIntNode(int node) {
    return YamlIntNode(node);
  }

  @override
  IIterableNode<T> createIterableNode<T>(Iterable<T> node) {
    return YamlIterableNode(
      node.map(
        (item) => INode.create(item, this) as INode<T>,
      ),
    );
  }

  @override
  IMapNode createMapNode(Map<dynamic, dynamic> node) {
    return YamlMapNode(
      node.map(
        (key, value) => MapEntry(
          key,
          INode.create(value, this),
        ),
      ),
    );
  }

  @override
  INullNode createNullNode() {
    return YamlNullNode();
  }

  @override
  IStringNode createStringNode(String node) {
    return YamlStringNode(node);
  }
}
