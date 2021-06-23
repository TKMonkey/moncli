import 'package:moncli/src/models/moncli_map.dart';
import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_null_node.dart';

class YamlMapNode extends MoncliMap implements IMapNode {
  static final IMapNode sEmpty = YamlMapNode(<String, INode>{});

  final Map<String, INode> _value;

  YamlMapNode(this._value) : super(const YamlNullNode(), _value);

  Set<String> get requiresEmptyLineSpace => const {"fonts"};

  @override
  Map<String, INode> get value => Map.unmodifiable(_value);

  @override
  Map<String, INode> get mutableValue => Map.of(_value);

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    final StringBuffer ss = StringBuffer();
    int newIndentation = currentIndentation;
    if (!isTopLevel) {
      ss.writeln();
      newIndentation += 2;
    }

    _value.forEach(
      (k, v) {
        if (requiresEmptyLineSpace.contains(k)) {
          ss.writeln();
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
