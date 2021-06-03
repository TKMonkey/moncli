import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_double_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_int_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_iterable_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_map_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_string_node.dart';
import 'package:test/test.dart';

class Input {
  final Map<String, INode> value;
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
  group("YamlMapNode", () {
    Map<String, INode> getCustomMap() {
      return Map.fromEntries(
        [
          const MapEntry(
            'aString',
            YamlStringNode("aStringValue"),
          ),
          const MapEntry(
            'anInt',
            YamlIntNode(15),
          ),
          const MapEntry(
            'aDouble',
            YamlDoubleNode(15.0),
          ),
          const MapEntry(
            'anIterable',
            YamlIterableNode(
              [
                YamlIntNode(15),
                YamlIntNode(16),
              ],
            ),
          ),
          const MapEntry(
            'fonts',
            YamlIterableNode(
              [
                YamlStringNode("aFont"),
                YamlStringNode("anotherFont"),
              ],
            ),
          ),
          const MapEntry(
            'aMap',
            YamlMapNode(
              {
                'anInternalInt': YamlIntNode(15),
                'anotherInternalInt': YamlIntNode(16)
              },
            ),
          ),
        ],
      );
    }

    group("Constructor", () {
      test("empty map param. value must be an empty map", () {
        // Arrange
        const yamlMapNode = YamlMapNode({});

        // Act
        final value = yamlMapNode.value;

        // Assert
        expect(value, isEmpty);
      });

      test(
          "non-empty map param. value must be an iterable with the same entries as param",
          () {
        // Arrange
        final yamlMapNode = YamlMapNode(getCustomMap());

        // Act
        final value = yamlMapNode.value;

        // Assert
        expect(value['aString']?.value, equals("aStringValue"));
        expect(value['anInt']?.value, equals(15));
        expect(value['aDouble']?.value, equals(15.0));
        expect(value['anIterable']?.value[0]?.value, equals(15));
        expect(value['anIterable']?.value[1]?.value, equals(16));
        expect(value['aMap']?.value['anInternalInt']?.value, equals(15));
        expect(value['aMap']?.value['anotherInternalInt']?.value, equals(16));
      });
    });

    group("validate", () {
      test("should not call node validator validateValue with own value", () {
        // Arrange
        final nodeValidator = MockNodeValidator(key: "aKey");
        const Map<String, INode> nodeMap = {
          "key1": YamlIntNode(1),
          "key2": YamlStringNode("aString")
        };
        const yamlMapNode = YamlMapNode(nodeMap);

        // Act
        // ignore: cascade_invocations
        yamlMapNode.validate(nodeValidator);

        // Assert
        expect(nodeValidator.receivedValue, isNull);
      });
    });

    test("mutableValue, should return a mutable map instance", () {
      // Arrange
      const Map<String, INode> nodeMap = {
        "key1": YamlIntNode(1),
        "key2": YamlStringNode("aString")
      };
      const yamlMapNode = YamlMapNode(nodeMap);

      // Act
      final mutableValue = yamlMapNode.mutableValue;
      mutableValue["aNewKey"] = const YamlIntNode(3);

      // Assert
      expect(mutableValue["aNewKey"]?.value, equals(3));
    });

    group("toSerializedString", () {
      final inputAndExpected = {
        Input(
          value: getCustomMap(),
          currentIndentation: 0,
          topLevelValue: true,
        ): "aString: aStringValue\nanInt: 15\naDouble: !!float 15.0\nanIterable: \n  - 15\n  - 16\n\nfonts: \n  - aFont\n  - anotherFont\naMap: \n  anInternalInt: 15\n  anotherInternalInt: 16\n",
        Input(
          value: getCustomMap(),
          currentIndentation: 0,
          topLevelValue: false,
        ): "\n  aString: aStringValue\n  anInt: 15\n  aDouble: !!float 15.0\n  anIterable: \n    - 15\n    - 16\n\n  fonts: \n    - aFont\n    - anotherFont\n  aMap: \n    anInternalInt: 15\n    anotherInternalInt: 16\n",
        Input(
          value: getCustomMap(),
          currentIndentation: 10,
          topLevelValue: true,
        ): "          aString: aStringValue\n          anInt: 15\n          aDouble: !!float 15.0\n          anIterable: \n            - 15\n            - 16\n\n          fonts: \n            - aFont\n            - anotherFont\n          aMap: \n            anInternalInt: 15\n            anotherInternalInt: 16\n",
        Input(
          value: getCustomMap(),
          currentIndentation: 10,
          topLevelValue: false,
        ): "\n            aString: aStringValue\n            anInt: 15\n            aDouble: !!float 15.0\n            anIterable: \n              - 15\n              - 16\n\n            fonts: \n              - aFont\n              - anotherFont\n            aMap: \n              anInternalInt: 15\n              anotherInternalInt: 16\n",
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
          final yamlIterableNode = YamlMapNode(nodeValue);
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
