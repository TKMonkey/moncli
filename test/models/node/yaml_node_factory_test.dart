import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/models/yaml/node/yaml_null_node.dart';
import 'package:test/test.dart';

void main() {
  group("YamlNodeFactory", () {
    test("emptyIIterableNode, must be empty", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final emptyIterable = yamlNodeFactory.emptyIIterableNode();

      // Assert
      expect(emptyIterable, isEmpty);
    });

    test("emptyIMapNode, must be empty", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final emptyMap = yamlNodeFactory.emptyIMapNode;

      // Assert
      expect(emptyMap, isEmpty);
    });

    test("emptyStringNode, must be empty", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final emptyString = yamlNodeFactory.emptyStringNode;

      // Assert
      expect(emptyString.value, isEmpty);
    });

    test("emptyStringNode, must be empty", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final emptyString = yamlNodeFactory.emptyStringNode;

      // Assert
      expect(emptyString.value, isEmpty);
    });

    test("createBoolNode, must be an IBoolNode with passed value", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final yamlBoolNode = yamlNodeFactory.createBoolNode(false);

      // Assert
      expect(yamlBoolNode.value, isFalse);
    });

    test("createDoubleNode, must be an IDoubleNode with passed value", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final yamlDoubleNode = yamlNodeFactory.createDoubleNode(2.1);

      // Assert
      expect(yamlDoubleNode.value, equals(2.1));
    });

    test("createDynamicNode, must be an IDynamicNode with passed value", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final yamlDynamicNode = yamlNodeFactory.createDynamicNode(2.1);

      // Assert
      expect(yamlDynamicNode.value, equals(2.1));
    });

    test("createIntNode, must be an IIntNode with passed value", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final yamlIntNode = yamlNodeFactory.createIntNode(2);

      // Assert
      expect(yamlIntNode.value, equals(2));
    });

    test("createIterableNode, must be an IIterableNode with passed values", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;
      final iterable = List.of([1, 2, 3]);

      // Act
      final yamlIterableNode = yamlNodeFactory.createIterableNode(iterable);
      final mappedIterable = yamlIterableNode.value.map((item) => item.value);

      // Assert
      int index = 0;
      for (final value in mappedIterable) {
        expect(value, equals(iterable[index]));
        index++;
      }
    });

    test("createMapNode, must be an IMapNode with passed entries", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;
      final map = Map.of({"key1": 1, "key2": 2});

      // Act
      final yamlMapNode = yamlNodeFactory.createMapNode(map);
      final mappedMap = yamlMapNode.value;

      // Assert
      for (final entry in mappedMap.entries) {
        expect(entry.value.value, equals(map[entry.key]));
      }
    });

    test("createNullNode, must be a YamlNullNode instance", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final yamlNullNode = yamlNodeFactory.createNullNode();

      // Assert
      expect(yamlNullNode, isA<YamlNullNode>());
    });

    test("createStringNode, must be an IStringNode with passed value", () {
      // Arrange
      const yamlNodeFactory = YamlNodeFactory.sInstance;

      // Act
      final yamlStringNode = yamlNodeFactory.createStringNode("aNewString");

      // Assert
      expect(yamlStringNode.value, equals("aNewString"));
    });
  });
}
