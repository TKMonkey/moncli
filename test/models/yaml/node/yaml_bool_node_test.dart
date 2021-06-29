import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_bool_node.dart';
import 'package:test/test.dart';

class Input {
  final bool value;
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
  group("YamlBoolNode", () {
    group("Constructor", () {
      test("true param, value must be true", () {
        // Arrange
        const yamlBoolNode = YamlBoolNode(true);
        // Act
        final value = yamlBoolNode.value;

        // Assert
        expect(value, isTrue);
      });

      test("false param, value must be false", () {
        // Arrange
        const yamlBoolNode = YamlBoolNode(false);
        // Act
        final value = yamlBoolNode.value;

        // Assert
        expect(value, isFalse);
      });
    });

    group("validate", () {
      test("should not call node validator validateValue with own value", () {
        // Arrange
        final nodeValidator = MockNodeValidator(key: "aKey");
        const yamlBoolNode = YamlBoolNode(true);

        // Act
        // ignore: cascade_invocations
        yamlBoolNode.validate(nodeValidator);

        // Assert
        expect(nodeValidator.receivedValue, isNull);
      });
    });

    group("toSerializedString", () {
      final inputAndExpected = {
        Input(value: true, currentIndentation: 0, topLevelValue: true):
            "true\n",
        Input(value: true, currentIndentation: 0, topLevelValue: false):
            "true\n",
        Input(value: true, currentIndentation: 10, topLevelValue: true):
            "true\n",
        Input(value: true, currentIndentation: 10, topLevelValue: false):
            "true\n",
        Input(value: false, currentIndentation: 0, topLevelValue: true):
            "false\n",
        Input(value: false, currentIndentation: 0, topLevelValue: false):
            "false\n",
        Input(value: false, currentIndentation: 10, topLevelValue: true):
            "false\n",
        Input(value: false, currentIndentation: 10, topLevelValue: false):
            "false\n",
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
          final yamlBoolNode = YamlBoolNode(nodeValue);
          // Act
          final serializedString = yamlBoolNode.toSerializedString(
              currentIndentation, topLevelValue);

          // Assert
          expect(serializedString, expected);
        });
      });
    });

    group("test", () {
      test("true should equals another true instance", () {
        // Arrange
        const myNode = YamlBoolNode(true);

        // Assert
        expect(myNode, YamlBoolNode(true));
      });

      test("false should equals another false instance", () {
        // Arrange
        const myNode = YamlBoolNode(false);

        // Assert
        expect(myNode, YamlBoolNode(false));
      });
    });

    group("hashCode", () {
      test("same node value should return same hashCode", () {
        // Arrange
        const myNode = YamlBoolNode(true);

        // Act
        final hashCode = myNode.hashCode;

        // Assert
        expect(hashCode, YamlBoolNode(true).hashCode);
      });

      test("different node value should return different hashCode", () {
        // Arrange
        const myNode = YamlBoolNode(true);

        // Act
        final hashCode = myNode.hashCode;

        // Assert
        expect(hashCode, isNot(YamlBoolNode(false).hashCode));
      });
    });
  });
}
