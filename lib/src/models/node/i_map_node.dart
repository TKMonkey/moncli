import 'package:moncli/src/models/node/i_node.dart';

abstract class IMapNode implements INode<Map<String, INode>> {
  Map<String, INode> get mutableValue;
}
