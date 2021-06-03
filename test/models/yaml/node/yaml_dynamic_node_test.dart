import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_dynamic_node.dart';
import 'package:test/test.dart';

class TestClass {
  final String name;
  final int age;

  const TestClass({required this.name, required this.age});

  @override
  String toString() {
    return 'TestClass{name: $name, age: $age}';
  }
}

class Input {
  final dynamic value;
  final int currentIndentation;
  final bool topLevelValue;

  Input(
      {required this.value,
      required this.currentIndentation,
      required this.topLevelValue});
}

class MockNodeValidator extends NodeValidator {
  dynamic? receivedValue;

  MockNodeValidator(
      {required String key, Iterable<String> validValues = const []})
      : super(key: key, validValues: validValues);

  @override
  void validateValue(value) {
    receivedValue = value;
    super.validateValue(value);
  }
}

void main() {
  group("Constructor", () {
    test("class param, value must be the received param", () {
      // Arrange
      const testObject = TestClass(name: "myName", age: 29);
      const yamlDynamiNode = YamlDynamicNode(testObject);
      // Act
      final value = yamlDynamiNode.value;
      // Assert
      expect(value, equals(testObject));
    });
  });

  group("validate", () {
    test("should call node validator validateValue with own value", () {
      // Arrange
      final nodeValidator = MockNodeValidator(key: "aKey");
      const yamlDynamicNode = YamlDynamicNode("Testing");

      // Act
      // ignore: cascade_invocations
      yamlDynamicNode.validate(nodeValidator);

      // Assert
      expect(nodeValidator.receivedValue, equals("Testing"));
    });

    test("validation not passed, should return invalid node validator", () {
      // Arrange
      final nodeValidator =
          MockNodeValidator(key: "aKey", validValues: ["aTest", 'anotherTest']);
      const yamlDynamicNode = YamlDynamicNode("Testing");

      // Act
      // ignore: cascade_invocations
      final newNodeValidator = yamlDynamicNode.validate(nodeValidator);

      // Assert
      expect(newNodeValidator.isValid, isFalse);
    });
  });

  group("toSerializedString", () {
    final inputAndExpected = {
      Input(
          value: const TestClass(name: "James", age: 29),
          currentIndentation: 0,
          topLevelValue: true): "TestClass{name: James, age: 29}\n",
      Input(
          value: const TestClass(name: "James", age: 29),
          currentIndentation: 0,
          topLevelValue: false): "TestClass{name: James, age: 29}\n",
      Input(
          value: const TestClass(name: "James", age: 29),
          currentIndentation: 10,
          topLevelValue: true): "TestClass{name: James, age: 29}\n",
      Input(
          value: const TestClass(name: "James", age: 29),
          currentIndentation: 10,
          topLevelValue: false): "TestClass{name: James, age: 29}\n",
      Input(
          value: const TestClass(name: "John", age: 100),
          currentIndentation: 0,
          topLevelValue: true): "TestClass{name: John, age: 100}\n",
      Input(
          value: const TestClass(name: "John", age: 100),
          currentIndentation: 0,
          topLevelValue: false): "TestClass{name: John, age: 100}\n",
      Input(
          value: const TestClass(name: "John", age: 100),
          currentIndentation: 10,
          topLevelValue: true): "TestClass{name: John, age: 100}\n",
      Input(
          value: const TestClass(name: "John", age: 100),
          currentIndentation: 10,
          topLevelValue: false): "TestClass{name: John, age: 100}\n",
      Input(
          value: const TestClass(name: "Robinson", age: 33),
          currentIndentation: 0,
          topLevelValue: true): "TestClass{name: Robinson, age: 33}\n",
      Input(
          value: const TestClass(name: "Robinson", age: 33),
          currentIndentation: 0,
          topLevelValue: false): "TestClass{name: Robinson, age: 33}\n",
      Input(
          value: const TestClass(name: "Robinson", age: 33),
          currentIndentation: 10,
          topLevelValue: true): "TestClass{name: Robinson, age: 33}\n",
      Input(
          value: const TestClass(name: "Robinson", age: 33),
          currentIndentation: 10,
          topLevelValue: false): "TestClass{name: Robinson, age: 33}\n",
    };

    // ignore: cascade_invocations
    inputAndExpected.forEach((key, value) {
      final nodeValue = key.value;
      final currentIndentation = key.currentIndentation;
      final topLevelValue = key.topLevelValue;
      final expected = value;

      test(
          "$nodeValue value, $currentIndentation currentIndentation and $topLevelValue topLevelValue, must return $expected",
          () {
        // Arrange
        final yamlDynamicNode = YamlDynamicNode(nodeValue);
        // Act
        final serializedString = yamlDynamicNode.toSerializedString(
            currentIndentation, topLevelValue);

        // Assert
        expect(serializedString, expected);
      });
    });
  });
}
