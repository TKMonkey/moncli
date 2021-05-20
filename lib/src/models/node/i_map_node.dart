import 'package:moncli/src/models/node/i_node.dart';

abstract class IMapNode implements INode<Map<String, INode>> {
  IMapNode get empty;
  Map<String, INode> get mutableValue;
}
