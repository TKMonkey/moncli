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

void main() {
  group("YamlBoolNode", () {
    group("Constructor", () {
      test("true param, value must be true", () {
        // Arrange
        final yamlBoolNode = YamlBoolNode(true);
        // Act
        final value = yamlBoolNode.value;

        // Assert
        expect(value, isTrue);
      });

      test("false param, value must be false", () {
        // Arrange
        final yamlBoolNode = YamlBoolNode(false);
        // Act
        final value = yamlBoolNode.value;

        // Assert
        expect(value, isFalse);
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
  });
}
