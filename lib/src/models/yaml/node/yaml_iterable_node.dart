import 'dart:collection';

import 'package:moncli/src/models/node/i_iterable_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';

class YamlIterableNode<T> with IterableMixin implements IIterableNode<T> {
  static YamlIterableNode<T> sEmpty<T>() =>
      YamlIterableNode<T>(Iterable<INode<T>>.empty());

  final Iterable<INode<T>> _value;

  const YamlIterableNode(this._value);

  @override
  Iterator get iterator => value.iterator;

  @override
  Iterable<INode<T>> get value => List.unmodifiable(_value);

  @override
  List<INode<T>> get mutableValue => List.of(_value);

  @override
  IIterableNode<R> castTo<R>() {
    return YamlNodeFactory.sInstance
        .createIterableNode<R>(_value.map((item) => item.value as R));
  }

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    final StringBuffer ss = StringBuffer();
    int newIndentation = currentIndentation;
    if (!isTopLevel) {
      ss.writeln();
      newIndentation += 2;
    }
    for (final node in _value) {
      _writeIndent(newIndentation, ss);
      ss
        ..write('- ')
        ..write(
          node.toSerializedString(
            newIndentation,
            false,
          ),
        );
    }

    return ss.toString();
  }

  @override
  String toString() {
    return 'YamlIterableNode{_value: $_value}';
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) {
    return elementValidator;
  }

  void _writeIndent(int indentation, StringSink ss) =>
      ss.write(' ' * indentation);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YamlIterableNode &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.fold(
      0,
      (previousValue, element) =>
          previousValue.hashCode + 31 ^ element.hashCode);
}
