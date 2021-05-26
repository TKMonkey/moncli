import 'package:moncli/src/base/exceptions/exceptions.dart';
import 'package:moncli/src/models/moncli_map.dart';
import 'package:moncli/src/models/node/i_iterable_node.dart';
import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/i_string_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class NullNode implements INullNode {
  const NullNode();

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return "";
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) {
    return elementValidator;
  }

  @override
  void get value => {};
}

MoncliMap createMoncliMap() {
  const nullNodeInstance = NullNode();
  return MoncliMap(nullNodeInstance);
}

class MapNode implements IMapNode {
  final Map<String, INode> _value;

  const MapNode(this._value);

  @override
  IMapNode get empty => const MapNode({});

  @override
  Map<String, INode> get mutableValue => Map.from(_value);

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return "serialized string";
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) {
    return elementValidator;
  }

  @override
  Map<String, INode> get value => Map.unmodifiable(_value);
}

class StringNode implements IStringNode {
  final String _value;

  StringNode(this._value);

  @override
  IStringNode get empty => StringNode("");

  @override
  String toSerializedString(int currentIndentation, bool isTopLevel) {
    return _value;
  }

  @override
  NodeValidator validate(NodeValidator elementValidator) =>
      elementValidator..validateValue(_value);

  @override
  String get value => _value;
}

void main() {
  test("Should return passed INullNode instance instead of null", () {
    //Arrange
    final moncliMap = createMoncliMap();

    //Act
    final nonExistingValue = moncliMap["nonExistingKey"];

    //Assert
    expect(nonExistingValue, isNotNull);
  });

  group("getNodeAs", () {
    test("Should return INode casted to non-generic INode class", () {
      //Arrange
      final moncliMap = createMoncliMap();

      //Act
      const mapNode = MapNode({"oneKey": NullNode()});
      moncliMap["customMap"] = mapNode;

      //Assert
      expect(moncliMap.getNodeAs<MapNode>("customMap"), isA<IMapNode>());
    });

    test("Should throw an exception if casting to the wrong type", () {
      //Arrange
      final moncliMap = createMoncliMap();

      //Act
      const mapNode = MapNode({"oneKey": NullNode()});
      moncliMap["customMap"] = mapNode;

      //Assert
      expect(() => moncliMap.getNodeAs<IIterableNode<String>>("customMap"),
          throwsA(isA<TypeError>()));
    });
  });

  group("getNodeOrDefault", () {
    test("Should return actual value if key set", () {
      //Arrange
      final moncliMap = createMoncliMap();

      // Act
      const mapNode = MapNode({"oneKey": NullNode()});
      moncliMap["customMap"] = mapNode;
      final actualValue = moncliMap.getNodeOrDefault(
          "customMap", const MapNode({"anotherKey": NullNode()}));

      // Assert
      expect(actualValue, equals(mapNode));
    });

    test("Should return default value if key not set", () {
      //Arrange
      final moncliMap = createMoncliMap();

      // Act
      const defaultMap = MapNode({"anotherKey": NullNode()});
      final actualValue = moncliMap.getNodeOrDefault("customMap", defaultMap);

      // Assert
      expect(actualValue, equals(defaultMap));
    });
  });

  group("getNodeOrException", () {
    test("Should return actual value if key set", () {
      //Arrange
      final moncliMap = createMoncliMap();

      // Act
      const mapNode = MapNode({"oneKey": NullNode()});
      moncliMap["customMap"] = mapNode;
      final actualValue = moncliMap.getNodeOrException("customMap");

      // Assert
      expect(actualValue, equals(mapNode));
    });

    test("Should throw KeyException if key not set", () {
      //Arrange
      final moncliMap = createMoncliMap();

      // Assert
      expect(() => moncliMap.getNodeOrException("customMap"),
          throwsA(isA<KeyNoFoundException>()));
    });
  });

  group("validate", () {
    test("Should return empty iterable if no errors found", () {
      // Arrange
      final nodeValidator1 = NodeValidator(
          key: "name", validValues: ["James", "Juan", "Robinson"]);
      final moncliMap = createMoncliMap();
      final nameNode = StringNode("James");

      moncliMap["name"] = nameNode;

      // Act
      final validatorResult = moncliMap.getValidation([nodeValidator1]);

      // Assert
      expect(validatorResult, isEmpty);
    });

    test("Should return non empty iterable if errors found", () {
      // Arrange
      final nodeValidator1 = NodeValidator(
          key: "name", validValues: ["James", "Juan", "Robinson"]);
      final moncliMap = createMoncliMap();
      final nameNode = StringNode("James1");

      moncliMap["name"] = nameNode;

      // Act
      final validatorResult = moncliMap.getValidation([nodeValidator1]);

      // Assert
      expect(validatorResult, isNotEmpty);
    });
  });
}
