import 'package:moncli/src/models/node/i_string_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

class YamlStringNode implements IStringNode {
  static const sEmpty = YamlStringNode('');

  static final specialCharacters = {
    ':',
    '{',
    '}',
    '[',
    ']',
    ',',
    '&',
    '*',
    '#',
    '?',
    '|',
    '-',
    '<',
    '>',
    '=',
    '!',
    '%',
    '@',
    ')',
    '`'
  };

  final String _value;

  const YamlStringNode(this._value);

  @override
  String get value => _value;

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    final StringBuffer ss = StringBuffer();

    /// quotes if string contains special characters
    if (_mustAddQuotes(_value)) {
      ss.writeln("'${_escapeString(_value)}'");

      /// most numbers are found to be strings, and they should be displayed as
      /// such, not as numbers
    } else if (int.tryParse(_value) != null ||
        double.tryParse(_value) != null) {
      ss.writeln(_escapeString(_value));

      /// if contains escape sequences, maintain those
    } else if (_value.contains('\r') ||
        _value.contains('\n') ||
        _value.contains('\t')) {
      ss.writeln(_withEscapes(_value));
    } else if (_value.contains('\\')) {
      ss.writeln(_escapeString(_value).replaceAll(r'\', r'\\'));
    } else {
      ss.writeln(_escapeString(_value));
    }

    return ss.toString();
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) =>
      elementValidator..validateValue(_value);

  @override
  String toString() {
    return 'YamlStringNode{_value: $_value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlStringNode &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  String _withEscapes(String s) => s
      .replaceAll('\r', '\\r')
      .replaceAll('\t', '\\t')
      .replaceAll('\n', '\\n')
      .replaceAll('\"', '\\"');

  String _escapeString(String s) =>
      s.replaceAll('"', r'\"').replaceAll('\n', r'\n');

  bool _mustAddQuotes(String node) =>
      specialCharacters.any((element) => node.contains(element));
}
