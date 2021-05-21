import 'package:moncli/src/models/yaml/line/empty_line.dart';
import 'package:moncli/src/models/yaml/line/key_line.dart';
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

  void writeIntoSink(StringSink sink, Yaml yaml);

  @override
  String toString() => line;
}

class CommentLine extends YamlLine {
  const CommentLine(String line) : super(line);

  @override
  void writeIntoSink(StringSink sink, Yaml yaml) {
    sink.writeln(line);
  }
}

class SubLine extends YamlLine {
  const SubLine(String line) : super(line);

  @override
  void writeIntoSink(StringSink sink, Yaml yaml) {
    sink.writeln(line);
  }
}
