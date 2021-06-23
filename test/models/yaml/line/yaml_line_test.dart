import 'package:moncli/src/models/yaml/line/comment_line.dart';
import 'package:moncli/src/models/yaml/line/empty_line.dart';
import 'package:moncli/src/models/yaml/line/key_line.dart';
import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:test/test.dart';

void main() {
  group("create", () {
    group("EmptyLine", () {
      test("empty string, should create EmptyLine", () {
        // Arrange
        const string = "";

        // Act
        final createdLine = YamlLine.create(string);

        // Assert
        expect(createdLine, isA<EmptyLine>());
      });

      test("all space chars string, should create EmptyLine", () {
        // Arrange
        const string = "      ";

        // Act
        final createdLine = YamlLine.create(string);

        // Assert
        expect(createdLine, isA<EmptyLine>());
      });
    });

    group("CommentLine", () {
      test("string starting with #, should create a CommentLine", () {
        // Arrange
        const string = "# A Comment";

        // Act
        final createdLine = YamlLine.create(string);

        // Assert
        expect(createdLine, isA<CommentLine>());
      });
    });

    group("KeyLine", () {
      test("key without value, must return a KeyLine", () {
        // Arrange
        const string = "name:";

        // Act
        final createdLine = YamlLine.create(string);

        // Assert
        expect(createdLine, isA<KeyLine>());
      });

      test("key with value, must return a KeyLine", () {
        // Arrange
        const string = "name: moncli";

        // Act
        final createdLine = YamlLine.create(string);

        // Assert
        expect(createdLine, isA<KeyLine>());
      });
    });

    test("passina a subnode, must return null", () {
      // Arrange
      const string = "  name: moncli";

      // Act
      final createdLine = YamlLine.create(string);

      // Assert
      expect(createdLine, isNull);
    });
  });
}
