import 'package:moncli/src/models/yaml/node/yaml_string_node.dart';
import 'package:test/test.dart';

class Input {
  final String value;
  final int currentIndentation;
  final bool topLevelValue;

  Input(
      {required this.value,
      required this.currentIndentation,
      required this.topLevelValue});
}

void main() {
  group("YamlStringNode", () {
    group("Constructor", () {
      test("empty string param, value must be an empty string", () {
        // Arrange
        const yamlStringNode = YamlStringNode("");

        // Act
        final value = yamlStringNode.value;

        // Assert
        expect(value, equals(""));
      });

      test("non-empty string param, value must be same as param", () {
        // Arrange
        const yamlStringNode = YamlStringNode("testing");

        // Act
        final value = yamlStringNode.value;

        // Assert
        expect(value, equals("testing"));
      });
    });

    group("toSerializedString", () {
      group("Any string", () {
        final inputAndExpected = {
          Input(value: "", currentIndentation: 0, topLevelValue: true): "\n",
          Input(value: "", currentIndentation: 0, topLevelValue: false): "\n",
          Input(value: "", currentIndentation: 10, topLevelValue: true): "\n",
          Input(value: "", currentIndentation: 10, topLevelValue: false): "\n",
          Input(
              value: "A normal text",
              currentIndentation: 0,
              topLevelValue: true): "A normal text\n",
          Input(
              value: "A normal text",
              currentIndentation: 0,
              topLevelValue: false): "A normal text\n",
          Input(
              value: "A normal text",
              currentIndentation: 10,
              topLevelValue: true): "A normal text\n",
          Input(
              value: "A normal text",
              currentIndentation: 10,
              topLevelValue: false): "A normal text\n",
          Input(
              value: "A very very very very very long text",
              currentIndentation: 0,
              topLevelValue: true): "A very very very very very long text\n",
          Input(
              value: "A very very very very very long text",
              currentIndentation: 0,
              topLevelValue: false): "A very very very very very long text\n",
          Input(
              value: "A very very very very very long text",
              currentIndentation: 10,
              topLevelValue: true): "A very very very very very long text\n",
          Input(
              value: "A very very very very very long text",
              currentIndentation: 10,
              topLevelValue: false): "A very very very very very long text\n",
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
            final yamlStringNode = YamlStringNode(nodeValue);

            // Act
            final serializedString = yamlStringNode.toSerializedString(
                currentIndentation, topLevelValue);

            // Assert
            expect(serializedString, expected);
          });
        });
      });

      group("with special char", () {
        final inputAndExpected = {
          Input(
              value: "test with special char :",
              currentIndentation: 10,
              topLevelValue: true): "'test with special char :'\n",
          Input(
              value: "test with special char :",
              currentIndentation: 10,
              topLevelValue: false): "'test with special char :'\n",
          Input(
              value: "test with special char :",
              currentIndentation: 0,
              topLevelValue: false): "'test with special char :'\n"
        };

        for (final char in YamlStringNode.specialCharacters) {
          final textWithSpecialChar = "test with special char $char";
          final input = Input(
              value: textWithSpecialChar,
              currentIndentation: 0,
              topLevelValue: true);

          inputAndExpected[input] = "'$textWithSpecialChar'\n";
        }

        inputAndExpected.forEach((key, value) {
          final nodeValue = key.value;
          final currentIndentation = key.currentIndentation;
          final topLevelValue = key.topLevelValue;
          final expected = value;

          test(
              "$nodeValue value, $currentIndentation currentIndentation and $topLevelValue topLevelValue, must return $expected",
              () {
            // Arrange
            final yamlStringNode = YamlStringNode(nodeValue);

            // Act
            final serializedString = yamlStringNode.toSerializedString(
                currentIndentation, topLevelValue);

            // Assert
            expect(serializedString, expected);
          });
        });
      });

      group("numbers", () {
        group("int", () {
          final inputAndExpected = {
            Input(value: "1", currentIndentation: 0, topLevelValue: true):
                "1\n",
            Input(value: "1", currentIndentation: 0, topLevelValue: false):
                "1\n",
            Input(value: "1", currentIndentation: 10, topLevelValue: true):
                "1\n",
            Input(value: "1", currentIndentation: 10, topLevelValue: false):
                "1\n",
            Input(value: "10", currentIndentation: 0, topLevelValue: true):
                "10\n",
            Input(value: "10", currentIndentation: 0, topLevelValue: false):
                "10\n",
            Input(value: "10", currentIndentation: 10, topLevelValue: true):
                "10\n",
            Input(value: "10", currentIndentation: 10, topLevelValue: false):
                "10\n",
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
              final yamlStringNode = YamlStringNode(nodeValue);

              // Act
              final serializedString = yamlStringNode.toSerializedString(
                  currentIndentation, topLevelValue);

              // Assert
              expect(serializedString, expected);
            });
          });
        });

        group("doubles", () {
          final inputAndExpected = {
            Input(value: "1.0", currentIndentation: 0, topLevelValue: true):
                "1.0\n",
            Input(value: "1.0", currentIndentation: 0, topLevelValue: false):
                "1.0\n",
            Input(value: "1.0", currentIndentation: 10, topLevelValue: true):
                "1.0\n",
            Input(value: "1.0", currentIndentation: 10, topLevelValue: false):
                "1.0\n",
            Input(value: "10.0", currentIndentation: 0, topLevelValue: true):
                "10.0\n",
            Input(value: "10.0", currentIndentation: 0, topLevelValue: false):
                "10.0\n",
            Input(value: "10.0", currentIndentation: 10, topLevelValue: true):
                "10.0\n",
            Input(value: "10.0", currentIndentation: 10, topLevelValue: false):
                "10.0\n",
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
              final yamlStringNode = YamlStringNode(nodeValue);

              // Act
              final serializedString = yamlStringNode.toSerializedString(
                  currentIndentation, topLevelValue);

              // Assert
              expect(serializedString, expected);
            });
          });
        });
      });
      group("escaped sequences", () {
        group("\\n \\t and \\r", () {
          final inputAndExpected = {
            Input(
                value: "text with \r",
                currentIndentation: 0,
                topLevelValue: true): "text with \\r\n",
            Input(
                value: "text with \r",
                currentIndentation: 0,
                topLevelValue: false): "text with \\r\n",
            Input(
                value: "text with \r",
                currentIndentation: 10,
                topLevelValue: true): "text with \\r\n",
            Input(
                value: "text with \r",
                currentIndentation: 10,
                topLevelValue: false): "text with \\r\n",
            Input(
                value: "text with \n",
                currentIndentation: 0,
                topLevelValue: true): "text with \\n\n",
            Input(
                value: "text with \n",
                currentIndentation: 0,
                topLevelValue: false): "text with \\n\n",
            Input(
                value: "text with \n",
                currentIndentation: 10,
                topLevelValue: true): "text with \\n\n",
            Input(
                value: "text with \n",
                currentIndentation: 10,
                topLevelValue: false): "text with \\n\n",
            Input(
                value: "text with \t",
                currentIndentation: 0,
                topLevelValue: true): "text with \\t\n",
            Input(
                value: "text with \t",
                currentIndentation: 00,
                topLevelValue: false): "text with \\t\n",
            Input(
                value: "text with \t",
                currentIndentation: 10,
                topLevelValue: true): "text with \\t\n",
            Input(
                value: "text with \t",
                currentIndentation: 10,
                topLevelValue: false): "text with \\t\n",
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
              final yamlStringNode = YamlStringNode(nodeValue);

              // Act
              final serializedString = yamlStringNode.toSerializedString(
                  currentIndentation, topLevelValue);

              // Assert
              expect(serializedString, expected);
            });
          });
        });
        group("\\", () {
          final inputAndExpected = {
            Input(
                value: "text with \\",
                currentIndentation: 0,
                topLevelValue: true): "text with \\\\\n",
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
              final yamlStringNode = YamlStringNode(nodeValue);

              // Act
              final serializedString = yamlStringNode.toSerializedString(
                  currentIndentation, topLevelValue);

              // Assert
              expect(serializedString, expected);
            });
          });
        });
      });
    });
  });
}
