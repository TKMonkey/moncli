import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_int_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_iterable_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_string_node.dart';
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
        final params = List<YamlIntNode>.from([
          const YamlIntNode(1),
          const YamlIntNode(2),
          const YamlIntNode(3),
          const YamlIntNode(4)
        ]);
        final yamlIterableNode = YamlIterableNode(params);

        // Act
        final value = yamlIterableNode.value;

        // Assert
        expect(value, equals(params));
      });
    });

    group("empty", () {
      test("should return an empty iterable", () {
        // Act
        final empty = YamlIterableNode.sEmpty();

        // Assert
        expect(empty.value, isEmpty);
      });
    });

    group("validate", () {
      test("should not call node validator validateValue with own value", () {
        // Arrange
        final nodeValidator = MockNodeValidator(key: "aKey");
        const nodeIterable = [YamlIntNode(1), YamlIntNode(2)];
        const yamlIterableNode = YamlIterableNode(nodeIterable);

        // Act
        // ignore: cascade_invocations
        yamlIterableNode.validate(nodeValidator);

        // Assert
        expect(nodeValidator.receivedValue, isNull);
      });
    });

    test("mutableValue, should return a mutable list instance", () {
      // Arrange
      const nodeIterable = [YamlIntNode(1), YamlIntNode(2)];
      const yamlIterableNode = YamlIterableNode(nodeIterable);

      // Act
      final mutableValue = yamlIterableNode.mutableValue
        ..add(const YamlIntNode(3));

      // Assert
      expect(mutableValue[2].value, equals(3));
    });

    group("castTo", () {
      test("should cast elements in list to T", () {
        // Arrange
        const nodeIterable = [YamlIntNode(1), YamlIntNode(2)];
        const yamlIterableNode = YamlIterableNode(nodeIterable);

        // Act
        final newIterableNode = yamlIterableNode.castTo<int>();

        // Assert

        var index = 0;
        for (final i in newIterableNode) {
          expect(i.value, equals(nodeIterable[index].value));
          index++;
        }
      });
    });

    group("toSerializedString", () {
      final yamlIntNodes = List<YamlIntNode>.from([
        const YamlIntNode(1),
        const YamlIntNode(2),
        const YamlIntNode(3),
        const YamlIntNode(4),
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

    test("equals", () {
      // Arrange
      const myNode = YamlIterableNode(
        [
          YamlStringNode("aString"),
          YamlStringNode("anotherString"),
        ],
      );

      // Assert
      expect(
        myNode,
        YamlIterableNode(
          [
            YamlStringNode("aString"),
            YamlStringNode("anotherString"),
          ],
        ),
      );
    });
  });
}
