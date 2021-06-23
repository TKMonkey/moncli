import 'package:moncli/src/models/node/i_node.dart';

abstract class IIterableNode<T> implements INode<Iterable<INode<T>>>, Iterable {
  Iterable<INode<T>> get mutableValue;

  IIterableNode<R> castTo<R>();
}
