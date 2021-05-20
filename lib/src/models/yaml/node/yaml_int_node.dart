import 'package:moncli/src/models/node/i_int_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlIntNode implements IIntNode {
  final int _value;

  YamlIntNode(this._value);

  @override
  int get value => _value;

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return "${value.toString()}\n";
  }

  @override
  String toString() {
    return 'YamlIntNode{_value: $_value}';
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) =>
      elementValidator..validateValue(_value);
}
