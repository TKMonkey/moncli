import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_double_node.dart';
import 'package:test/test.dart';

class Input {
  final double value;
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
      {required String key, Iterable<dynamic> validValues = const []})
      : super(key: key, validValues: validValues);

  @override
  void validateValue(value) {
    receivedValue = value;
    super.validateValue(value);
  }
}

void main() {
  group("Constructor", () {
    test("positive param, value must be the received param", () {
      // Arrange
      const yamlDoubleNode = YamlDoubleNode(10.5);
      // Act
      final value = yamlDoubleNode.value;
      // Assert
      expect(value, equals(10.5));
    });

    test("negative param, value must be the received param", () {
      // Arrange
      const yamlDoubleNode = YamlDoubleNode(-10.5);
      // Act
      final value = yamlDoubleNode.value;
      // Assert
      expect(value, equals(-10.5));
    });

    test("zero param, value must be the received param", () {
      // Arrange
      const yamlDoubleNode = YamlDoubleNode(0.5);
      // Act
      final value = yamlDoubleNode.value;
      // Assert
      expect(value, equals(0.5));
    });
  });

  group("validate", () {
    test("should call node validator validateValue with own value", () {
      // Arrange
      final nodeValidator = MockNodeValidator(key: "aKey");
      const yamlDoubleNode = YamlDoubleNode(2.1);

      // Act
      // ignore: cascade_invocations
      yamlDoubleNode.validate(nodeValidator);

      // Assert
      expect(nodeValidator.receivedValue, equals(2.1));
    });

    test("validation not passed, should return invalid node validator", () {
      // Arrange
      final nodeValidator =
          MockNodeValidator(key: "aKey", validValues: [1.1, 2.2]);
      const yamlDoubleNode = YamlDoubleNode(2.1);

      // Act
      // ignore: cascade_invocations
      final newNodeValidator = yamlDoubleNode.validate(nodeValidator);

      // Assert
      expect(newNodeValidator.isValid, isFalse);
    });
  });

  group("toSerializedString", () {
    final inputAndExpected = {
      Input(value: 10.5, currentIndentation: 0, topLevelValue: true):
          "!!float 10.5\n",
      Input(value: 10.5, currentIndentation: 0, topLevelValue: false):
          "!!float 10.5\n",
      Input(value: 10.5, currentIndentation: 10, topLevelValue: true):
          "!!float 10.5\n",
      Input(value: 10.5, currentIndentation: 10, topLevelValue: false):
          "!!float 10.5\n",
      Input(value: -10.5, currentIndentation: 0, topLevelValue: true):
          "!!float -10.5\n",
      Input(value: -10.5, currentIndentation: 0, topLevelValue: false):
          "!!float -10.5\n",
      Input(value: -10.5, currentIndentation: 10, topLevelValue: true):
          "!!float -10.5\n",
      Input(value: -10.5, currentIndentation: 10, topLevelValue: false):
          "!!float -10.5\n",
      Input(value: 0.5, currentIndentation: 0, topLevelValue: true):
          "!!float 0.5\n",
      Input(value: 0.5, currentIndentation: 0, topLevelValue: false):
          "!!float 0.5\n",
      Input(value: 0.5, currentIndentation: 10, topLevelValue: true):
          "!!float 0.5\n",
      Input(value: 0.5, currentIndentation: 10, topLevelValue: false):
          "!!float 0.5\n",
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
        final yamlBoolNode = YamlDoubleNode(nodeValue);
        // Act
        final serializedString =
            yamlBoolNode.toSerializedString(currentIndentation, topLevelValue);

        // Assert
        expect(serializedString, expected);
      });
    });

    test("equals", () {
      // Arrange
      const myNode = YamlDoubleNode(5.3);

      // Assert
      expect(myNode, YamlDoubleNode(5.3));
    });

    group("hashCode", () {
      test("same node value should return same hashCode", () {
        // Arrange
        const myNode = YamlDoubleNode(1.4);

        // Act
        final hashCode = myNode.hashCode;

        // Assert
        expect(hashCode, YamlDoubleNode(1.4).hashCode);
      });

      test("different node value should return different hashCode", () {
        // Arrange
        const myNode = YamlDoubleNode(2.5);

        // Act
        final hashCode = myNode.hashCode;

        // Assert
        expect(hashCode, isNot(YamlDoubleNode(1.1).hashCode));
      });
    });
  });
}
