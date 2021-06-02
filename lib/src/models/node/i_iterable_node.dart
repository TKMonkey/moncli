import 'package:moncli/src/models/node/i_node.dart';

abstract class IIterableNode<T> implements INode<Iterable<INode<T>>> {
  IIterableNode<R> castTo<R>();
}
