import 'package:moncli/src/models/line.dart';
import 'package:moncli/src/models/yaml/line/comment_line.dart';
import 'package:moncli/src/models/yaml/line/empty_line.dart';
import 'package:moncli/src/models/yaml/line/key_line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

abstract class YamlLine extends Line {
  static bool _isEmptyNode(String lineStr, Iterable<YamlLine> lines) =>
      lineStr.isEmpty && lines.isNotEmpty && lines.last is! EmptyLine;

  static bool _isCommentNode(String lineStr) => lineStr.startsWith('#');

  static bool _isSubNode(String lineStr) =>
      lineStr.startsWith(' ') || !lineStr.contains(':');

  static bool _isKeyNode(String lineStr, Iterable<YamlLine> lines) =>
      !_isEmptyNode(lineStr, lines) &&
      !_isCommentNode(lineStr) &&
      !_isSubNode(lineStr);

  const YamlLine(String line) : super(line);

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
}
