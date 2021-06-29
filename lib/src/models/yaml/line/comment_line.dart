import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

class CommentLine extends YamlLine {
  const CommentLine(String line) : super(line);

  @override
  void writeIntoSink(StringSink sink, Yaml yaml) {
    sink.writeln(line);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentLine && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
