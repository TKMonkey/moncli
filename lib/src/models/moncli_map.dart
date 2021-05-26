import "package:meta/meta.dart";
import 'package:moncli/src/base/exceptions/exceptions.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/utils/logger/colors.dart';
import 'package:moncli/src/utils/logger/logger.dart';

/// Map subclass to store INode instances
///
/// This subclass is in charge of storing mapped config files and
/// returns INullNode instead of null value if no value is set for key
class MoncliMap implements Map<String, INode> {
  @protected
  Map<String, INode> internalMap;
  final INullNode _nullNode;

  MoncliMap(this._nullNode, [Map<String, INode>? internalMap])
      : internalMap = internalMap ?? Map.from({});

  @override
  INode operator [](Object? key) {
    return internalMap.containsKey(key) ? internalMap[key]! : _nullNode;
  }

  @override
  void operator []=(String key, INode value) {
    internalMap[key] = value;
  }

  @override
  void addAll(Map<String, INode> other) {
    internalMap.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<String, INode>> newEntries) {
    internalMap.addEntries(newEntries);
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return internalMap.cast<RK, RV>();
  }

  @override
  void clear() {
    internalMap.clear();
  }

  @override
  bool containsKey(Object? key) {
    return internalMap.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return internalMap.containsValue(value);
  }

  @override
  Iterable<MapEntry<String, INode>> get entries => internalMap.entries;

  @override
  void forEach(void Function(String key, INode value) action) {
    internalMap.forEach(action);
  }

  @override
  bool get isEmpty => internalMap.isEmpty;

  @override
  bool get isNotEmpty => internalMap.isNotEmpty;

  @override
  Iterable<String> get keys => internalMap.keys;

  @override
  int get length => internalMap.length;

  @override
  Map<K2, V2> map<K2, V2>(
      MapEntry<K2, V2> Function(String key, INode value) convert) {
    return internalMap.map(convert);
  }

  @override
  INode putIfAbsent(String key, INode Function() ifAbsent) {
    return internalMap.putIfAbsent(key, ifAbsent);
  }

  @override
  INode? remove(Object? key) {
    return internalMap.remove(key);
  }

  @override
  void removeWhere(bool Function(String key, INode value) test) {
    return internalMap.removeWhere(test);
  }

  @override
  INode update(String key, INode Function(INode value) update,
      {INode Function()? ifAbsent}) {
    return internalMap.update(key, update, ifAbsent: ifAbsent);
  }

  @override
  void updateAll(INode Function(String key, INode value) update) {
    internalMap.updateAll(update);
  }

  @override
  Iterable<INode> get values => internalMap.values;

  @override
  String toString() {
    return 'MoncliMap{_map: $internalMap}';
  }

  T? getNodeAs<T extends INode>(String key) {
    return this[key] as T?;
  }

  T getNodeOrDefault<T extends INode>(String key, T defaultValue) {
    return this[key] is INullNode ? defaultValue : this[key] as T;
  }

  INode getNodeOrException(String key, {String? fileName}) {
    final value = this[key];
    if (value is INullNode) {
      throw KeyNoFoundException(key, fileName: fileName);
    }

    return value;
  }

  void validate(List<NodeValidator> validators) {
    final filter = validators
        .map((validator) => this[validator.key].validate(validator))
        .where((element) => !element.isValid)
        .toList()
        .asMap()
        .map((key, validator) => MapEntry(validator.key, validator.reason));

    reportErrorsValidator(filter);
  }

  void reportErrorsValidator(Map<String, String> validateMap) {
    if (validateMap.isNotEmpty) {
      logger.err('Errors with validators');
      for (final element in validateMap.entries) {
        logger.info('${yellow(element.key)}: ${element.value}');
      }

      throw const ValidatorsException();
    }
  }
}
