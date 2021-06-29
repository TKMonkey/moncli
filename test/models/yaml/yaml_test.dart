import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/yaml/line/comment_line.dart';
import 'package:moncli/src/models/yaml/line/empty_line.dart';
import 'package:moncli/src/models/yaml/line/key_line.dart';
import 'package:moncli/src/models/yaml/line/yaml_line.dart';
import 'package:moncli/src/models/yaml/node/yaml_bool_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_int_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_iterable_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_map_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_null_node.dart';
import 'package:moncli/src/models/yaml/node/yaml_string_node.dart';
import 'package:moncli/src/models/yaml/yaml.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

const yamlString = '''
name: moncli
description: A sample command-line application.
# version: 1.0.0
# homepage: https://www.example.com

environment:
  sdk: '>=2.12.0 <3.0.0'

dependencies:
  ansicolor: ^2.0.1

one_key: true
array: [a, b, c]
map: { a: 1, e: { x: 0, z: false, anotherNullValue:}}
nullValue:
fonts: [font1, font2, font3]
''';

void main() {
  group("Yaml", () {
    Yaml expectedYamlMap() {
      final myMap = Yaml(internalMap: {}, fileLines: []);

      const nameNode = YamlStringNode("moncli");
      myMap["name"] = nameNode;
      const descriptionNode =
          YamlStringNode("A sample command-line application.");
      myMap["description"] = descriptionNode;
      final environmentNode = YamlMapNode(Map.fromEntries(
          [const MapEntry("sdk", YamlStringNode(">=2.12.0 <3.0.0"))]));
      myMap["environment"] = environmentNode;

      final dependenciesNode = YamlMapNode(Map.fromEntries(
          [const MapEntry("ansicolor", YamlStringNode("^2.0.1"))]));
      myMap["dependencies"] = dependenciesNode;

      const oneKeyNode = YamlBoolNode(true);
      myMap["one_key"] = oneKeyNode;

      const arrayNode = YamlIterableNode(
          [YamlStringNode("a"), YamlStringNode("b"), YamlStringNode("c")]);
      myMap["array"] = arrayNode;

      final mapNode = YamlMapNode(Map.fromEntries([
        const MapEntry("a", YamlIntNode(1)),
        MapEntry(
            "e",
            YamlMapNode(Map.fromEntries([
              const MapEntry("x", YamlIntNode(0)),
              const MapEntry("z", YamlBoolNode(false)),
              const MapEntry("anotherNullValue", YamlNullNode())
            ])))
      ]));
      myMap["map"] = mapNode;

      myMap["nullValue"] = const YamlNullNode();

      const fontsNode = YamlIterableNode([
        YamlStringNode("font1"),
        YamlStringNode("font2"),
        YamlStringNode("font3")
      ]);
      myMap["fonts"] = fontsNode;

      return myMap;
    }

    test("loadYamlMap", () {
      //Arrange
      final yamlMap = Yaml.loadYamlMap(yamlString);

      //Assert
      expect(yamlMap, expectedYamlMap());
    });

    group("putIfAbsent", () {
      test("key exists in yaml, should not call ifAbsent", () {
        // Arrange
        final yaml = Yaml(
            internalMap: {"aKey": const YamlStringNode("original")},
            fileLines: []);

        int ifAbsentCallCount = 0;

        INode ifAbsent() {
          ifAbsentCallCount++;
          return const YamlStringNode("Hola");
        }

        // Act
        yaml.putIfAbsent("aKey", ifAbsent);

        // Assert
        expect(ifAbsentCallCount, isZero);
      });

      test("key does not exist in yaml, should call ifAbsent only once", () {
        // Arrange
        final yaml = Yaml(internalMap: {}, fileLines: []);

        int ifAbsentCallCount = 0;

        INode ifAbsent() {
          ifAbsentCallCount++;
          return const YamlStringNode("Hola");
        }

        // Act
        yaml.putIfAbsent("aKey", ifAbsent);

        // Assert
        expect(ifAbsentCallCount, 1);
      });
    });

    group("[]=", () {
      test("should add key into yaml", () {
        // Arrange
        final yaml = Yaml(internalMap: {}, fileLines: []);

        // Act
        yaml["aKey"] = const YamlStringNode("Hola");

        // Assert
        expect(yaml["aKey"], const YamlStringNode("Hola"));
      });

      test("key does not exist in yaml, should add line into lines", () {
        // Arrange
        final yaml = Yaml(internalMap: {}, fileLines: []);

        // Act
        yaml["aKey"] = const YamlStringNode("Hola");

        // Assert
        expect(yaml.lines, [KeyLine("aKey:")]);
      });

      test("key already exists in yaml, should add only one line into lines",
          () {
        // Arrange
        final yaml = Yaml(internalMap: {}, fileLines: []);

        yaml["aKey"] = const YamlStringNode("Hola");

        // Act
        // ignore: cascade_invocations
        yaml["aKey"] = const YamlStringNode("Hola2");

        // Assert
        expect(yaml.lines, [KeyLine("aKey:")]);
      });
    });

    group("addAll", () {
      test("should add all keys from otherYaml into yaml", () {
        // Arrange
        final yaml = Yaml(internalMap: {}, fileLines: []);
        final otherYaml = Yaml(internalMap: {}, fileLines: []);

        otherYaml["aKey"] = const YamlStringNode("Hola");
        otherYaml["anotherKey"] = const YamlStringNode("Hola2");

        // Act
        // ignore: cascade_invocations
        yaml.addAll(otherYaml);

        // Assert
        expect(yaml["aKey"], const YamlStringNode("Hola"));
        expect(yaml["anotherKey"], const YamlStringNode("Hola2"));
      });

      test("keys do not exist in yaml, should add all lines into lines", () {
        // Arrange
        final yaml = Yaml(internalMap: {}, fileLines: []);
        final otherYaml = Yaml(internalMap: {}, fileLines: []);

        otherYaml["aKey"] = const YamlStringNode("Hola");
        otherYaml["anotherKey"] = const YamlStringNode("Hola2");

        // Act
        yaml.addAll(otherYaml);

        // Assert
        expect(yaml.lines, [KeyLine("aKey:"), KeyLine("anotherKey:")]);
      });
    });

    group("addEntries", () {
      test("should add all keys from otherYaml into yaml", () {
        // Arrange
        final yaml = Yaml(internalMap: {}, fileLines: []);
        final otherYaml = Yaml(internalMap: {}, fileLines: []);

        otherYaml["aKey"] = const YamlStringNode("Hola");
        otherYaml["anotherKey"] = const YamlStringNode("Hola2");

        // Act
        // ignore: cascade_invocations
        yaml.addEntries(otherYaml.entries);

        // Assert
        expect(yaml["aKey"], const YamlStringNode("Hola"));
        expect(yaml["anotherKey"], const YamlStringNode("Hola2"));
      });

      test("keys do not exist in yaml, should add all lines into lines", () {
        // Arrange
        final yaml = Yaml(internalMap: {}, fileLines: []);
        final otherYaml = Yaml(internalMap: {}, fileLines: []);

        otherYaml["aKey"] = const YamlStringNode("Hola");
        otherYaml["anotherKey"] = const YamlStringNode("Hola2");

        // Act
        yaml.addEntries(otherYaml.entries);

        // Assert
        expect(yaml.lines, [KeyLine("aKey:"), KeyLine("anotherKey:")]);
      });
    });

    group("lines", () {
      final expectedLines = <YamlLine>[
        KeyLine("name: moncli"),
        KeyLine("description: A sample command-line application."),
        const CommentLine("# version: 1.0.0"),
        const CommentLine("# homepage: https://www.example.com"),
        const EmptyLine(),
        KeyLine("environment:"),
        const EmptyLine(),
        KeyLine("dependencies:"),
        const EmptyLine(),
        KeyLine("one_key: true"),
        KeyLine("array: [a, b, c]"),
        KeyLine("map: { a: 1, e: { x: 0, z: false, anotherNullValue:}}"),
        KeyLine("nullValue:"),
        KeyLine("fonts: [font1, font2, font3]"),
        const EmptyLine(),
      ];

      test("After creation, lines must contain only main lines", () {
        // Arrange
        final yaml = Yaml.create(
            yamlString: yamlString, fileLines: yamlString.split("\n"));
        // Act
        final lines = yaml.lines;
        // Assert
        expect(lines, expectedLines);
      });
    });

    test("toYamlString", () {
      // Arrange
      final yaml = Yaml(internalMap: {}, fileLines: []);

      yaml["aKey"] = const YamlStringNode("Hola");
      yaml["anotherKey"] = const YamlStringNode("Hola2");

      // Act
      final yamlString = yaml.toYamlString();

      // Assert
      expect(yamlString, "aKey: Hola\nanotherKey: Hola2\n");
    });
  });
}
