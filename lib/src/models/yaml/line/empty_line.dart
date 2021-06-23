import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

class EmptyLine extends YamlLine {
  const EmptyLine() : super('');

  @override
  void writeIntoSink(StringSink sink, Yaml yaml) {
    sink.writeln(line);
  }
}
