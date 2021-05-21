import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

abstract class YamlLine {
  static bool _isEmptyNode(String lineStr, Iterable<YamlLine> lines) =>
      lineStr.isEmpty && lines.isNotEmpty && lines.last is! EmptyLine;

  static bool _isCommentNode(String lineStr) => lineStr.startsWith('#');

  static bool _isSubNode(String lineStr) =>
      lineStr.startsWith(' ') || !lineStr.contains(':');

  static bool _isKeyNode(String lineStr, Iterable<YamlLine> lines) =>
      !_isEmptyNode(lineStr, lines) &&
      !_isCommentNode(lineStr) &&
      !_isSubNode(lineStr);

  const YamlLine(this.line);

  final String line;

  static YamlLine? create(String string, Iterable<YamlLine> lines) {
    if (_isKeyNode(string, lines)) {
      return KeyLine(string);
    }

    if (_isEmptyNode(string, lines)) {
      return const EmptyLine();
    }

    if (_isCommentNode(string)) {
      return CommentLine(string);
    }
  }

  @override
  String toString() => line;
}

class EmptyLine extends YamlLine {
  const EmptyLine() : super('');
}

class KeyLine extends YamlLine {
  KeyLine(String line) : super(line) {
    final split = line.split(' ');
    key = _getKey(split);
    value = _getValue(split);
    other = _getOther(split);
  }

  final subNodes = <YamlLine>[];
  late final String key;
  late final String value;
  late final String other;

  void add(YamlLine subNode) {
    subNodes.add(subNode);
  }

  String _getKey(List<String> split) => split[0].replaceAll(':', '');

  String _getValue(List<String> split) => split.length > 1 ? split[1] : '';

  String _getOther(List<String> split) => split.length > 2 ? split[2] : '';
}

class CommentLine extends YamlLine {
  const CommentLine(String line) : super(line);
}

class SubLine extends YamlLine {
  const SubLine(String line) : super(line);
}
