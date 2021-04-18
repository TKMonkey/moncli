import 'node_model.dart';

class YamlModel {
  final nodes = <Node>[];

  void readYaml(List<String> lines) {
    for (var i = 0; i < lines.length; i++) {
      if (isKeyNode(lines[i])) {
        final kn = KeyNode(lines[i]);
        nodes.add(kn);

        var innerIndex = i + 1;

        while (isValidRange(innerIndex, lines.length) && isSubNode(lines[innerIndex])) {
          final sn = SubNode(lines[innerIndex]);

          nodes.add(sn);
          kn.add(sn);

          innerIndex++;
        }
        i += innerIndex - 1 - i;
      } else if (isEmptyNode(lines[i])) {
        nodes.add(EmptyNode(lines[i]));
      } else if (isCommentNode(lines[i])) {
        nodes.add(CommentNode(lines[i]));
      }
    }
  }

  bool isValidRange(int i, int length) => i + 1 <= length;

  bool isEmptyNode(String line) => line.isEmpty;

  bool isCommentNode(String line) => line.trimLeft().startsWith('#');

  bool isSubNode(String line) => line.startsWith(' ') || !line.contains(':');

  bool isKeyNode(String line) =>
      !isEmptyNode(line) && !isCommentNode(line) && !isSubNode(line);

  @override
  String toString() => nodes.map((e) => e.line).toList().join('\n');
}
