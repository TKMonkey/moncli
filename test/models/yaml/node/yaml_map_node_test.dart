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
  group("YamlMapNode", () {
    Map<String, INode> getCustomMap() {
      return Map.fromEntries(
        [
          MapEntry(
            1.toString(),
            const YamlStringNode("aValueForAnIntKey"),
          ),
          MapEntry(
            true.toString(),
            const YamlStringNode("aValueForABoolKey"),
          ),
          MapEntry(
            3.0.toString(),
            const YamlStringNode("aValueForADoubleKey"),
          ),
          MapEntry(
            {"aKey": 10}.toString(),
            const YamlStringNode("aValueForAMapKey"),
          ),
          MapEntry(
            [1, 2, 3].toString(),
            const YamlStringNode("aValueForAnIterableKey"),
          ),
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
          MapEntry(
            'aMap',
            YamlMapNode(
              {
                'anInternalInt': const YamlIntNode(15),
                'anotherInternalInt': const YamlIntNode(16)
              },
            ),
          ),
        ],
      );
    }

    group("Constructor", () {
      test("empty map param. value must be an empty map", () {
        // Arrange
        final yamlMapNode = YamlMapNode({});

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
        expect(value["1"]?.value, equals("aValueForAnIntKey"));
        expect(value["true"]?.value, equals("aValueForABoolKey"));
        expect(value["3.0"]?.value, equals("aValueForADoubleKey"));
        expect(
            value[{"aKey": 10}.toString()]?.value, equals("aValueForAMapKey"));
        expect(value[[1, 2, 3].toString()]?.value,
            equals("aValueForAnIterableKey"));
        expect(value['aString']?.value, equals("aStringValue"));
        expect(value['anInt']?.value, equals(15));
        expect(value['aDouble']?.value, equals(15.0));
        expect(value['anIterable']?.value[0]?.value, equals(15));
        expect(value['anIterable']?.value[1]?.value, equals(16));
        expect(value['aMap']?.value['anInternalInt']?.value, equals(15));
        expect(value['aMap']?.value['anotherInternalInt']?.value, equals(16));
      });
    });

    test("sEmpty should be an empty map", () {
      // Act
      final empty = YamlMapNode.sEmpty;

      // Assert
      expect(empty, isEmpty);
    });

    group("validate", () {
      test("should not call node validator validateValue with own value", () {
        // Arrange
        final nodeValidator = MockNodeValidator(key: "aKey");
        const Map<String, INode> nodeMap = {
          "key1": YamlIntNode(1),
          "key2": YamlStringNode("aString")
        };
        final yamlMapNode = YamlMapNode(nodeMap);

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
      final yamlMapNode = YamlMapNode(nodeMap);

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
        ): '1: aValueForAnIntKey\ntrue: aValueForABoolKey\n3.0: aValueForADoubleKey\n{aKey: 10}: aValueForAMapKey\n[1, 2, 3]: aValueForAnIterableKey\naString: aStringValue\nanInt: 15\naDouble: !!float 15.0\nanIterable: \n  - 15\n  - 16\n\nfonts: \n  - aFont\n  - anotherFont\naMap: \n  anInternalInt: 15\n  anotherInternalInt: 16\n',
        Input(
          value: getCustomMap(),
          currentIndentation: 0,
          topLevelValue: false,
        ): '\n  1: aValueForAnIntKey\n  true: aValueForABoolKey\n  3.0: aValueForADoubleKey\n  {aKey: 10}: aValueForAMapKey\n  [1, 2, 3]: aValueForAnIterableKey\n  aString: aStringValue\n  anInt: 15\n  aDouble: !!float 15.0\n  anIterable: \n    - 15\n    - 16\n\n  fonts: \n    - aFont\n    - anotherFont\n  aMap: \n    anInternalInt: 15\n    anotherInternalInt: 16\n',
        Input(
          value: getCustomMap(),
          currentIndentation: 10,
          topLevelValue: true,
        ): "          1: aValueForAnIntKey\n          true: aValueForABoolKey\n          3.0: aValueForADoubleKey\n          {aKey: 10}: aValueForAMapKey\n          [1, 2, 3]: aValueForAnIterableKey\n          aString: aStringValue\n          anInt: 15\n          aDouble: !!float 15.0\n          anIterable: \n            - 15\n            - 16\n\n          fonts: \n            - aFont\n            - anotherFont\n          aMap: \n            anInternalInt: 15\n            anotherInternalInt: 16\n",
        Input(
          value: getCustomMap(),
          currentIndentation: 10,
          topLevelValue: false,
        ): "\n            1: aValueForAnIntKey\n            true: aValueForABoolKey\n            3.0: aValueForADoubleKey\n            {aKey: 10}: aValueForAMapKey\n            [1, 2, 3]: aValueForAnIterableKey\n            aString: aStringValue\n            anInt: 15\n            aDouble: !!float 15.0\n            anIterable: \n              - 15\n              - 16\n\n            fonts: \n              - aFont\n              - anotherFont\n            aMap: \n              anInternalInt: 15\n              anotherInternalInt: 16\n",
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
