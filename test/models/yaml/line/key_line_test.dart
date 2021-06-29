import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moncli/src/models/yaml/line/key_line.dart';
import 'package:moncli/src/models/yaml/node/yaml_iterable_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_string_node.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:test/test.dart';

import 'key_line_test.mocks.dart';

@GenerateMocks([Yaml])
void main() {
  group("KeyLine", () {
    group("writeIntoSink", () {
      test("should return a key and its string in the same line", () {
        // Arrange
        final yaml = MockYaml();
        const iStringNode = YamlStringNode("a string from the node");
        when(yaml["oneKey"]).thenReturn(iStringNode);
        final sink = StringBuffer();
        final keyLine = KeyLine(
            "oneKey: an original string that should not appear in result");

        // Act
        // ignore: cascade_invocations
        keyLine.writeIntoSink(sink, yaml);

        // Assert
        expect(sink.toString(), equals("oneKey: a string from the node\n"));
      });

      test("should return a key and its list correctly formatted", () {
        // Arrange
        final yaml = MockYaml();
        const iIterableNode = YamlIterableNode([
          YamlStringNode("a string from the node"),
          YamlStringNode("another string from the node")
        ]);
        when(yaml["oneKey"]).thenReturn(iIterableNode);
        final sink = StringBuffer();
        final keyLine = KeyLine(
            "oneKey: an original string that should not appear in result");

        // Act
        // ignore: cascade_invocations
        keyLine.writeIntoSink(sink, yaml);

        // Assert
        expect(
            sink.toString(),
            equals(
                "oneKey: \n  - a string from the node\n  - another string from the node\n"));
      });
    });

    test("equals", () {
      // Arrange
      final keyLine = KeyLine("aKey: a value");

      // Assert
      expect(keyLine, KeyLine("aKey: a value"));
    });

    group("hashCode", () {
      test("same line should return same hashCode", () {
        // Arrange
        final keyLine = KeyLine("aKey: a value");

        // Act
        final hashCode = keyLine.hashCode;

        // Assert
        expect(hashCode, KeyLine("aKey: a value").hashCode);
      });

      test("different line should return different hashCode", () {
        // Arrange
        final keyLine = KeyLine("aKey: a value");

        // Act
        final hashCode = keyLine.hashCode;

        // Assert
        expect(hashCode, isNot(KeyLine("anotherKey: another value").hashCode));
      });
    });
  });
}

// dart test --coverage coverage
// dart run coverage:format_coverage --packages=.packages -i coverage/test -l -o coverage/lcov.info --report-on=lib
// genhtml -o coverage coverage/lcov.info
// open coverage/index.html
