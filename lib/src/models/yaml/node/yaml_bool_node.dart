import 'package:moncli/src/models/node/i_bool_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlBoolNode implements IBoolNode {
  final bool _value;

  const YamlBoolNode(this._value);

  @override
  bool get value => _value;

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return "${value.toString()}\n";
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) {
    return elementValidator;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlBoolNode &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;
}
