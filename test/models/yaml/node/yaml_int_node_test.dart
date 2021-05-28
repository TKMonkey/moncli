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

void main() {
  group("Constructor", () {
    test("positive param, value must be the received param", () {
      // Arrange
      final yamlIntNode = YamlIntNode(10);
      // Act
      final value = yamlIntNode.value;
      // Assert
      expect(value, equals(10));
    });

    test("negative param, value must be the received param", () {
      // Arrange
      final yamlIntNode = YamlIntNode(-10);
      // Act
      final value = yamlIntNode.value;
      // Assert
      expect(value, equals(-10));
    });

    test("zero param, value must be the received param", () {
      // Arrange
      final yamlIntNode = YamlIntNode(0);
      // Act
      final value = yamlIntNode.value;
      // Assert
      expect(value, equals(0));
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
}
