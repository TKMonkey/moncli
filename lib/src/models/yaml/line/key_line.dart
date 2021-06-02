import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/yaml.dart';

class KeyLine extends YamlLine {
  KeyLine(String line) : super(line) {
    final split = line.split(' ');
    key = _getKey(split);
    value = _getValue(split);
    other = _getOther(split);
  }

  late final String key;
  late final String value;
  late final String other;

  String _getKey(List<String> split) => split[0].replaceAll(':', '');

  String _getValue(List<String> split) => split.length > 1 ? split[1] : '';

  String _getOther(List<String> split) => split.length > 2 ? split[2] : '';

  @override
  void writeIntoSink(StringSink sink, Yaml yaml) {
    final innerSink = StringBuffer();
    _writeYamlString(
        YamlNodeFactory.sInstance.createMapNode({key: yaml[key]}), innerSink);

    /// moves text to be inline with [hyphen '-']
    sink.write(innerSink.toString().replaceAll(RegExp(r'-\s\n\s*'), '- '));
  }

  /// Serializes [node] into a String and writes it to the [sink].
  void _writeYamlString(INode node, StringSink sink) {
    final yamlString = node.toSerializedString(0, true);
    sink.write(yamlString);
  }
}
