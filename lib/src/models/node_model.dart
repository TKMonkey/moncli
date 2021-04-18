abstract class Node {
  const Node(this.line);

  final String line;

  @override
  String toString() => line;
}

class EmptyNode extends Node {
  const EmptyNode(String line) : super(line);
}

class KeyNode extends Node {
  KeyNode(String line) : super(line) {
    final split = line.split(' ');
    key = _getKey(split);
    value = _getValue(split);
    other = _getOther(split);
  }

  final subNodes = <Node>[];
  late final String key;
  late final String value;
  late final String other;

  void add(Node subNode) {
    subNodes.add(subNode);
  }

  String _getKey(List<String> split) => split[0].replaceAll(':', '');

  String _getValue(List<String> split) => split.length > 1 ? split[1] : '';

  String _getOther(List<String> split) => split.length > 2 ? split[2] : '';
}

class CommentNode extends Node {
  const CommentNode(String line) : super(line);
}

class SubNode extends Node {
  const SubNode(String line) : super(line);
}
