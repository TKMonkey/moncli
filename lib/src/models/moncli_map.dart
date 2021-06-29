import 'dart:collection';

import 'package:moncli/src/base/exceptions/exceptions.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';

/// Map subclass to store INode instances
///
/// This subclass is in charge of storing mapped config files and
/// returns INullNode instead of null value if no value is set for key
class MoncliMap with MapMixin<String, INode> {
  final Map<String, INode> _internalMap;
  final INullNode _nullNode;

  MoncliMap(this._nullNode, [Map<String, INode>? internalMap])
      : _internalMap = internalMap ?? Map.from({});

  @override
  INode operator [](Object? key) =>
      containsKey(key) ? _internalMap[key]! : _nullNode;

  @override
  void operator []=(String key, INode value) => _internalMap[key] = value;

  @override
  void clear() => _internalMap.clear();

  @override
  Iterable<String> get keys => _internalMap.keys;

  @override
  INode? remove(Object? key) => _internalMap.remove(key);

  T? getNodeAs<T extends INode>(String key) => this[key] as T?;

  T getNodeOrDefault<T extends INode>(String key, T defaultValue) =>
      this[key] is INullNode ? defaultValue : this[key] as T;

  INode getNodeOrException(String key, {String? fileName}) {
    final value = this[key];
    if (value is INullNode) {
      throw KeyNotFoundException(key, fileName: fileName);
    }

    return value;
  }

  Iterable<NodeValidator> getValidation(Iterable<NodeValidator> validators) =>
      validators
          .map((validator) => this[validator.key].validate(validator))
          .where((element) => !element.isValid);
}
