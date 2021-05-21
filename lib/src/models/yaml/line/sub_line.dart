import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

class SubLine extends YamlLine {
  const SubLine(String line) : super(line);

  @override
  void writeIntoSink(StringSink sink, Yaml yaml) {
    sink.writeln(line);
  }
}
