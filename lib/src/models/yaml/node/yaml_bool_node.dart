import 'package:moncli/src/models/node/i_bool_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlBoolNode implements IBoolNode {
  final bool _value;

  YamlBoolNode(this._value);

  @override
  bool get value => _value;

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return "${value.toString()}\n";
  }

  @override
  String toString() {
    return 'YamlBoolNode{_value: $_value}';
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) {
    return elementValidator;
  }
}
