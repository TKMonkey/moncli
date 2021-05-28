import 'package:moncli/src/models/yaml/node/yaml_null_node.dart';
import 'package:test/test.dart';

class Input {
  final int currentIndentation;
  final bool topLevelValue;

  Input({required this.currentIndentation, required this.topLevelValue});
}

void main() {
  group("YamlNullNode", () {
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
          final yamlNullNode = YamlNullNode();

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
