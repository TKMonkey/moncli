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

void main() {
  group("Constructor", () {
    test("positive param, value must be the received param", () {
      // Arrange
      final yamlDoubleNode = YamlDoubleNode(10.5);
      // Act
      final value = yamlDoubleNode.value;
      // Assert
      expect(value, equals(10.5));
    });

    test("negative param, value must be the received param", () {
      // Arrange
      final yamlDoubleNode = YamlDoubleNode(-10.5);
      // Act
      final value = yamlDoubleNode.value;
      // Assert
      expect(value, equals(-10.5));
    });

    test("zero param, value must be the received param", () {
      // Arrange
      final yamlDoubleNode = YamlDoubleNode(0.5);
      // Act
      final value = yamlDoubleNode.value;
      // Assert
      expect(value, equals(0.5));
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
  });
}
