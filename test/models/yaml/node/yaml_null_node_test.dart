import 'package:moncli/src/models/node/node_validator.dart';
import 'package:moncli/src/models/yaml/node/yaml_null_node.dart';
import 'package:test/test.dart';

class Input {
  final int currentIndentation;
  final bool topLevelValue;

  Input({required this.currentIndentation, required this.topLevelValue});
}

class MockNodeValidator extends NodeValidator {
  dynamic? receivedValue = 1;

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
  group("YamlNullNode", () {
    test("value should be void", () {
      // Arrange
      const yamlNullNode = YamlNullNode();

      // Act
      // ignore: cascade_invocations
      yamlNullNode.value;
    });

    group("validate", () {
      test("should call node validator validateValue with null value", () {
        // Arrange
        final nodeValidator = MockNodeValidator(key: "aKey");
        const yamlNullNode = YamlNullNode();

        // Act
        // ignore: cascade_invocations
        yamlNullNode.validate(nodeValidator);

        // Assert
        expect(nodeValidator.receivedValue, isNull);
      });

      test("validation not passed, should return invalid node validator", () {
        // Arrange
        final nodeValidator = MockNodeValidator(key: "aKey");
        const yamlNullNode = YamlNullNode();

        // Act
        // ignore: cascade_invocations
        final newNodeValidator = yamlNullNode.validate(nodeValidator);

        // Assert
        expect(newNodeValidator.isValid, isFalse);
      });
    });

    group("toSerializedString", () {
      final inputAndExpected = {
        Input(currentIndentation: 0, topLevelValue: true): "\n",
        Input(currentIndentation: 0, topLevelValue: false): "\n",
        Input(currentIndentation: 10, topLevelValue: true): "\n",
        Input(currentIndentation: 10, topLevelValue: false): "\n",
      };

      // ignore: cascade_invocations
      inputAndExpected.forEach((key, value) {
        final currentIndentation = key.currentIndentation;
        final topLevelValue = key.topLevelValue;
        final expected = value;

        test(
            "$currentIndentation currentIndentation and $topLevelValue topLevelValue, must return $expected",
            () {
          // Arrange
          const yamlNullNode = YamlNullNode();

          // Act
          final serializedString = yamlNullNode.toSerializedString(
              currentIndentation, topLevelValue);

          // Assert
          expect(serializedString, expected);
        });
      });
    });
  });
}
