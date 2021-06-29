import 'package:mockito/annotations.dart';
import 'package:moncli/src/models/yaml/line/comment_line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:test/test.dart';

import 'comment_line_test.mocks.dart';

@GenerateMocks([Yaml])
void main() {
  group("KeyLine", () {
    group("writeIntoSink", () {
      test("comment string, should write the comment as such and a new line",
          () {
        // Arrange
        final yaml = MockYaml();
        final sink = StringBuffer();
        const emptyLine = CommentLine("# This is a comment line");

        // Act
        // ignore: cascade_invocations
        emptyLine.writeIntoSink(sink, yaml);

        // Assert
        expect(sink.toString(), equals("# This is a comment line\n"));
      });
    });

    test("comment", () {
      // Arrange
      const commentLine = CommentLine("# this is a comment line");

      // Assert
      expect(commentLine, CommentLine("# this is a comment line"));
    });

    group("hashCode", () {
      test("same line should return same hashCode", () {
        // Arrange
        const commentLine = CommentLine("# aKey: a value");

        // Act
        final hashCode = commentLine.hashCode;

        // Assert
        expect(hashCode, CommentLine("# aKey: a value").hashCode);
      });

      test("same line should return different hashCode", () {
        // Arrange
        const commentLine = CommentLine("# aKey: a value");

        // Act
        final hashCode = commentLine.hashCode;

        // Assert
        expect(hashCode,
            isNot(CommentLine("# anotherKey: another value").hashCode));
      });
    });
  });
}
