import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlNullNode implements INullNode {
  const YamlNullNode();

  @override
  void get value {}

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return '\n';
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) =>
      elementValidator..validateValue(null);
}
