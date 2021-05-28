import 'package:moncli/src/models/yaml/node/yaml_dynamic_node.dart';
import 'package:test/test.dart';

class TestClass {
  final String name;
  final int age;

  TestClass({required this.name, required this.age});

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

void main() {
  group("Constructor", () {
    test("class param, value must be the received param", () {
      // Arrange
      final testObject = TestClass(name: "myName", age: 29);
      final yamlDynamiNode = YamlDynamicNode(testObject);
      // Act
      final value = yamlDynamiNode.value;
      // Assert
      expect(value, equals(testObject));
    });
  });

  group("toSerializedString", () {
    final inputAndExpected = {
      Input(
          value: TestClass(name: "James", age: 29),
          currentIndentation: 0,
          topLevelValue: true): "TestClass{name: James, age: 29}\n",
      Input(
          value: TestClass(name: "James", age: 29),
          currentIndentation: 0,
          topLevelValue: false): "TestClass{name: James, age: 29}\n",
      Input(
          value: TestClass(name: "James", age: 29),
          currentIndentation: 10,
          topLevelValue: true): "TestClass{name: James, age: 29}\n",
      Input(
          value: TestClass(name: "James", age: 29),
          currentIndentation: 10,
          topLevelValue: false): "TestClass{name: James, age: 29}\n",
      Input(
          value: TestClass(name: "John", age: 100),
          currentIndentation: 0,
          topLevelValue: true): "TestClass{name: John, age: 100}\n",
      Input(
          value: TestClass(name: "John", age: 100),
          currentIndentation: 0,
          topLevelValue: false): "TestClass{name: John, age: 100}\n",
      Input(
          value: TestClass(name: "John", age: 100),
          currentIndentation: 10,
          topLevelValue: true): "TestClass{name: John, age: 100}\n",
      Input(
          value: TestClass(name: "John", age: 100),
          currentIndentation: 10,
          topLevelValue: false): "TestClass{name: John, age: 100}\n",
      Input(
          value: TestClass(name: "Robinson", age: 33),
          currentIndentation: 0,
          topLevelValue: true): "TestClass{name: Robinson, age: 33}\n",
      Input(
          value: TestClass(name: "Robinson", age: 33),
          currentIndentation: 0,
          topLevelValue: false): "TestClass{name: Robinson, age: 33}\n",
      Input(
          value: TestClass(name: "Robinson", age: 33),
          currentIndentation: 10,
          topLevelValue: true): "TestClass{name: Robinson, age: 33}\n",
      Input(
          value: TestClass(name: "Robinson", age: 33),
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
