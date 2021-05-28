import 'package:moncli/src/models/yaml/node/yaml_int_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_iterable_node.dart';
import 'package:test/test.dart';

class Input {
  final Iterable<YamlIntNode> value;
  final int currentIndentation;
  final bool topLevelValue;

  Input(
      {required this.value,
      required this.currentIndentation,
      required this.topLevelValue});
}

void main() {
  group("YamlIterableNode", () {
    group("Constructor", () {
      test("empty iterable param, value must be an empty iterable", () {
        // Arrange
        const yamlIterableNode = YamlIterableNode([]);

        // Act
        final value = yamlIterableNode.value;

        // Assert
        expect(value, isEmpty);
      });

      test(
          "non-empty iterable param, value must be an iterable with the same items as param",
          () {
        // Arrange
        final params = List<YamlIntNode>.from(
            [YamlIntNode(1), YamlIntNode(2), YamlIntNode(3), YamlIntNode(4)]);
        final yamlIterableNode = YamlIterableNode(params);

        // Act
        final value = yamlIterableNode.value;

        // Assert
        expect(value, equals(params));
      });
    });

    group("toSerializedString", () {
      final yamlIntNodes = List<YamlIntNode>.from([
        YamlIntNode(1),
        YamlIntNode(2),
        YamlIntNode(3),
        YamlIntNode(4),
      ]);

      final inputAndExpected = {
        Input(value: yamlIntNodes, currentIndentation: 0, topLevelValue: true):
            "- 1\n- 2\n- 3\n- 4\n",
        Input(value: yamlIntNodes, currentIndentation: 0, topLevelValue: false):
            "\n  - 1\n  - 2\n  - 3\n  - 4\n",
        Input(value: yamlIntNodes, currentIndentation: 10, topLevelValue: true):
            "          - 1\n          - 2\n          - 3\n          - 4\n",
        Input(
                value: yamlIntNodes,
                currentIndentation: 10,
                topLevelValue: false):
            "\n            - 1\n            - 2\n            - 3\n            - 4\n",
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
          final yamlIterableNode = YamlIterableNode(nodeValue);
          // Act
          final serializedString = yamlIterableNode.toSerializedString(
              currentIndentation, topLevelValue);

          // Assert
          expect(serializedString, expected);
        });
      });
    });
  });
}
