import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlNullNode implements INullNode {
  @override
  void get value {}

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return '';
  }

  @override
  String toString() {
    return 'YamlNullNode{}';
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) =>
      elementValidator..validateValue(null);
}
