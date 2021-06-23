import 'package:moncli/src/models/line.dart';
import 'package:moncli/src/models/yaml/line/comment_line.dart';
import 'package:moncli/src/models/yaml/line/empty_line.dart';
import 'package:moncli/src/models/yaml/line/key_line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

abstract class YamlLine extends Line {
  static bool _isEmptyNode(String lineStr) => lineStr.trim().isEmpty;

  static bool _isCommentNode(String lineStr) => lineStr.startsWith('#');

  static bool _isSubNode(String lineStr) =>
      lineStr.startsWith(' ') || !lineStr.contains(':');

  static bool _isKeyNode(String lineStr) =>
      !_isEmptyNode(lineStr) &&
      !_isCommentNode(lineStr) &&
      !_isSubNode(lineStr);

  const YamlLine(String line) : super(line);

  static YamlLine? create(String string) {
    if (_isKeyNode(string)) {
      return KeyLine(string);
    }

    if (_isEmptyNode(string)) {
      return const EmptyLine();
    }

    if (_isCommentNode(string)) {
      return CommentLine(string);
    }
  }

  void writeIntoSink(StringSink sink, Yaml yaml);
}
