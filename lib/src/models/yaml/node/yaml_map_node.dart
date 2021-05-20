import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlMapNode implements IMapNode {
  static const sEmpty = YamlMapNode(<String, INode>{});

  final Map<String, INode> _value;

  const YamlMapNode(this._value);

  @override
  IMapNode get empty => sEmpty;

  @override
  Map<String, INode> get value => Map.unmodifiable(_value);

  @override
  Map<String, INode> get mutableValue => Map.of(_value);

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    var firstFont = false;

    final StringBuffer ss = StringBuffer();
    int newIndentation = currentIndentation;
    if (!isTopLevel) {
      ss.writeln();
      newIndentation += 2;
    }

    _value.forEach(
      (k, v) {
        if (k == 'fonts' && v is List && !firstFont) {
          ss.writeln();
          firstFont = true;
        }
        _writeIndent(newIndentation, ss);
        ss
          ..write(k)
          ..write(': ')
          ..write(
            v.toSerializedString(
              newIndentation,
              false,
            ),
          );
      },
    );

    return ss.toString();
  }

  @override
  String toString() {
    return 'YamlMapNode{_value: $_value}';
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) {
    return elementValidator;
  }

  void _writeIndent(int indentation, StringSink ss) =>
      ss.write(' ' * indentation);
}
