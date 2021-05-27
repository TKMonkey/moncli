import 'package:moncli/src/models/node/node_validator.dart';
import 'package:test/test.dart';

void main() {
  group("validateValue", () {
    group("reason", () {
      test("is required and value is null, reason should be non empty", () {
        //Arrange
        final nodeValidator = NodeValidator(key: "testKey", validValues: []);

        //Act
        // ignore: cascade_invocations
        nodeValidator.validateValue(null);

        // Assert
        expect(nodeValidator.reason, isNotEmpty);
      });

      test("is not required and value is null, reason should be empty", () {
        //Arrange
        final nodeValidator =
            NodeValidator(key: "testKey", validValues: [], isRequired: false);

        //Act
        // ignore: cascade_invocations
        nodeValidator.validateValue(null);

        // Assert
        expect(nodeValidator.reason, isEmpty);
      });

      test("is required and value is valid, reason should be empty", () {
        //Arrange
        final nodeValidator = NodeValidator(key: "testKey", validValues: []);

        //Act
        // ignore: cascade_invocations
        nodeValidator.validateValue("");

        // Assert
        expect(nodeValidator.reason, isEmpty);
      });
    });

    group("isValid", () {
      group("required", () {
        test("null value, isValid should be set to false", () {
          //Arrange
          final nodeValidator = NodeValidator(key: "testKey", validValues: []);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue(null);

          // Assert
          expect(nodeValidator.isValid, isFalse);
        });
        test("non-empty value and empty validValues, isValid should be true",
            () {
          //Arrange
          final nodeValidator = NodeValidator(key: "testKey", validValues: []);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue("anyValue");

          // Assert
          expect(nodeValidator.isValid, isTrue);
        });

        test("empty value and empty validValues, isValid should be true", () {
          //Arrange
          final nodeValidator = NodeValidator(key: "testKey", validValues: []);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue("");

          // Assert
          expect(nodeValidator.isValid, isTrue);
        });

        test("non existing value in validValues, isValid should be false", () {
          //Arrange
          final nodeValidator =
              NodeValidator(key: "testKey", validValues: ["1", "2", "3", "4"]);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue("otherValue");

          // Assert
          expect(nodeValidator.isValid, isFalse);
        });

        test("existing value in validValues, isValid should be true", () {
          //Arrange
          final nodeValidator =
              NodeValidator(key: "testKey", validValues: ["1", "2", "3", "4"]);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue("1");

          // Assert
          expect(nodeValidator.isValid, isTrue);
        });
      });
      group("not required", () {
        test("null value, isValid should be set to true", () {
          //Arrange
          final nodeValidator =
              NodeValidator(key: "testKey", validValues: [], isRequired: false);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue(null);

          // Assert
          expect(nodeValidator.isValid, isTrue);
        });
        test("non-empty value and empty validValues, isValid should be true",
            () {
          //Arrange
          final nodeValidator =
              NodeValidator(key: "testKey", validValues: [], isRequired: false);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue("anyValue");

          // Assert
          expect(nodeValidator.isValid, isTrue);
        });

        test("empty value and empty validValues, isValid should be true", () {
          //Arrange
          final nodeValidator =
              NodeValidator(key: "testKey", validValues: [], isRequired: false);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue("");

          // Assert
          expect(nodeValidator.isValid, isTrue);
        });

        test("non existing value in validValues, isValid should be false", () {
          //Arrange
          final nodeValidator = NodeValidator(
              key: "testKey",
              validValues: ["1", "2", "3", "4"],
              isRequired: false);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue("otherValue");

          // Assert
          expect(nodeValidator.isValid, isFalse);
        });

        test("existing value in validValues, isValid should be true", () {
          //Arrange
          final nodeValidator = NodeValidator(
              key: "testKey",
              validValues: ["1", "2", "3", "4"],
              isRequired: false);

          //Act
          // ignore: cascade_invocations
          nodeValidator.validateValue("1");

          // Assert
          expect(nodeValidator.isValid, isTrue);
        });
      });
    });
  });

  group("toReasonMapEntry", () {
    test("empty reason, should build MapEntry with empty value", () {
      //Arrange
      final nodeValidator =
          NodeValidator(key: "testKey", validValues: ["1", "2", "3", "4"]);

      //Act
      // ignore: cascade_invocations
      final mapEntry = nodeValidator.toReasonMapEntry();

      // Assert
      const expectedMap = MapEntry("testKey", "");
      expect(mapEntry.key, equals(expectedMap.key));
      expect(mapEntry.value, equals(expectedMap.value));
    });

    test(
        "non-empty reason, should build MapEntry with nodeValidator reason as value",
        () {
      //Arrange
      final nodeValidator =
          NodeValidator(key: "testKey", validValues: ["1", "2", "3", "4"])
            ..validateValue("anotherValue");

      //Act
      // ignore: cascade_invocations
      final mapEntry = nodeValidator.toReasonMapEntry();

      // Assert
      expect(mapEntry.key, equals("testKey"));
      expect(mapEntry.value, equals(nodeValidator.reason));
    });
  });
}
