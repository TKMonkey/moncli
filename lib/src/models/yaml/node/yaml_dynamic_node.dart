import 'package:moncli/src/models/node/i_dynamic_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlDynamicNode implements IDynamicNode {
  final dynamic _value;

  YamlDynamicNode(this._value);

  @override
  dynamic get value => _value;

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return "${value.toString()}\n";
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) =>
      elementValidator..validateValue(_value);
}
