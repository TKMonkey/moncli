import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_int_node.dart';
import 'package:test/test.dart';

class Input {
  final int value;
  final int currentIndentation;
  final bool topLevelValue;

  Input(
      {required this.value,
      required this.currentIndentation,
      required this.topLevelValue});
}

class MockNodeValidator extends NodeValidator {
  dynamic receivedValue;

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
      const yamlIntNode = YamlIntNode(10);
      // Act
      final value = yamlIntNode.value;
      // Assert
      expect(value, equals(10));
    });

    test("negative param, value must be the received param", () {
      // Arrange
      const yamlIntNode = YamlIntNode(-10);
      // Act
      final value = yamlIntNode.value;
      // Assert
      expect(value, equals(-10));
    });

    test("zero param, value must be the received param", () {
      // Arrange
      const yamlIntNode = YamlIntNode(0);
      // Act
      final value = yamlIntNode.value;
      // Assert
      expect(value, equals(0));
    });
  });

  group("validate", () {
    test("should call node validator validateValue with own value", () {
      // Arrange
      final nodeValidator = MockNodeValidator(key: "aKey");
      const yamlIntNode = YamlIntNode(1);

      // Act
      // ignore: cascade_invocations
      yamlIntNode.validate(nodeValidator);

      // Assert
      expect(nodeValidator.receivedValue, equals(1));
    });

    test("validation not passed, should return invalid node validator", () {
      // Arrange
      final nodeValidator = MockNodeValidator(key: "aKey", validValues: [3, 4]);
      const yamlIntNode = YamlIntNode(1);

      // Act
      // ignore: cascade_invocations
      final newNodeValidator = yamlIntNode.validate(nodeValidator);

      // Assert
      expect(newNodeValidator.isValid, isFalse);
    });
  });

  group("toSerializedString", () {
    final inputAndExpected = {
      Input(value: 10, currentIndentation: 0, topLevelValue: true): "10\n",
      Input(value: 10, currentIndentation: 0, topLevelValue: false): "10\n",
      Input(value: 10, currentIndentation: 10, topLevelValue: true): "10\n",
      Input(value: 10, currentIndentation: 10, topLevelValue: false): "10\n",
      Input(value: -10, currentIndentation: 0, topLevelValue: true): "-10\n",
      Input(value: -10, currentIndentation: 0, topLevelValue: false): "-10\n",
      Input(value: -10, currentIndentation: 10, topLevelValue: true): "-10\n",
      Input(value: -10, currentIndentation: 10, topLevelValue: false): "-10\n",
      Input(value: 0, currentIndentation: 0, topLevelValue: true): "0\n",
      Input(value: 0, currentIndentation: 0, topLevelValue: false): "0\n",
      Input(value: 0, currentIndentation: 10, topLevelValue: true): "0\n",
      Input(value: 0, currentIndentation: 10, topLevelValue: false): "0\n",
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
        final yamlBoolNode = YamlIntNode(nodeValue);
        // Act
        final serializedString =
            yamlBoolNode.toSerializedString(currentIndentation, topLevelValue);

        // Assert
        expect(serializedString, expected);
      });
    });
  });

  test("group", () {
    // Arrange
    const myInt = YamlIntNode(1);

    // Assert
    expect(myInt, const YamlIntNode(1));
  });
}
