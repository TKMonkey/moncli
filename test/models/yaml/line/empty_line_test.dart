import 'package:mockito/annotations.dart';
import 'package:moncli/src/models/yaml/line/empty_line.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:test/test.dart';

import 'empty_line_test.mocks.dart';

@GenerateMocks([Yaml])
void main() {
  group("KeyLine", () {
    group("writeIntoSink", () {
      test("empty string, should write a new line", () {
        // Arrange
        final yaml = MockYaml();
        final sink = StringBuffer();
        const emptyLine = EmptyLine();

        // Act
        // ignore: cascade_invocations
        emptyLine.writeIntoSink(sink, yaml);

        // Assert
        expect(sink.toString(), equals("\n"));
      });
    });

    test("equals", () {
      // Arrange
      const emptyLine = EmptyLine();

      // Assert
      expect(emptyLine, EmptyLine());
    });

    test("hashCode, two EmptyLine instances must share hashCode", () {
      // Arrange
      const emptyLine = EmptyLine();

      // Act
      final hashCode = emptyLine.hashCode;

      // Assert
      expect(hashCode, EmptyLine().hashCode);
    });
  });
}
