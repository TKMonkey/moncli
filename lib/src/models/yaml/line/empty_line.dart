import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

class EmptyLine extends YamlLine {
  const EmptyLine() : super('');

  @override
  void writeIntoSink(StringSink sink, Yaml yaml) {
    sink.writeln(line);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other && other is EmptyLine && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;
}
