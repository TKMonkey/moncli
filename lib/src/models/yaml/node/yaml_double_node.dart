import 'package:moncli/src/models/node/i_double_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlDoubleNode implements IDoubleNode {
  final double _value;

  const YamlDoubleNode(this._value);

  @override
  double get value => _value;

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return "!!float ${_value.toString()}\n";
  }

  @override
  String toString() {
    return 'YamlDoubleNode{_value: $_value}';
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) =>
      elementValidator..validateValue(_value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlDoubleNode &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;
}
