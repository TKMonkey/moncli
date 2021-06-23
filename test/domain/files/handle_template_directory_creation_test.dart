import 'package:moncli/src/domain/files/create_path/i_create_template_directory.dart';
import 'package:moncli/src/domain/files/i_can_create_path/i_can_create_template_directory.dart';
import 'package:moncli/src/domain/files/i_exists/i_exists_template_directory.dart';
import 'package:moncli/src/domain/files/i_handle_template_directory_creation.dart';
import 'package:test/test.dart';

class StubExistsTemplateDirectory implements IExistsTemplateDirectory {
  final bool _valueToReturn;

  StubExistsTemplateDirectory(this._valueToReturn);

  @override
  bool call() {
    return _valueToReturn;
  }
}

class StubCanCreateTemplatesDirectory implements ICanCreateTemplatesDirectory {
  final bool _valueToReturn;

  StubCanCreateTemplatesDirectory(this._valueToReturn);

  @override
  bool call() {
    return _valueToReturn;
  }
}

class MockCreateTemplateDirectory implements ICreateTemplatesDirectory {
  int _callsCounter = 0;

  @override
  void call() {
    _callsCounter++;
  }

  int get callsCounter => _callsCounter;
}

void main() {
  group("HandleTemplateDirectoryCreation", () {
    test(
        "existsTemplateDirectory returns true, should not call createTemplatesDirectory",
        () {
      // Arrange
      final stubExistsTemplateDirectory = StubExistsTemplateDirectory(true);
      final mockCreateTemplatesDirectory = MockCreateTemplateDirectory();
      final stubCanCreateTemplatesDirectory =
          StubCanCreateTemplatesDirectory(true);
      final handleTemplateDirectoryCreation = HandleTemplateDirectoryCreation(
          stubExistsTemplateDirectory,
          mockCreateTemplatesDirectory,
          stubCanCreateTemplatesDirectory);

      // Act
      handleTemplateDirectoryCreation();

      // Assert
      expect(mockCreateTemplatesDirectory.callsCounter, isZero);
    });

    test(
        "existsTemplateDirectory returns false, canCreateTemplateDirectory returns false, should not call createTemplatesDirectory",
        () {
      // Arrange
      final stubExistsTemplateDirectory = StubExistsTemplateDirectory(false);
      final mockCreateTemplatesDirectory = MockCreateTemplateDirectory();
      final stubCanCreateTemplatesDirectory =
          StubCanCreateTemplatesDirectory(false);
      final handleTemplateDirectoryCreation = HandleTemplateDirectoryCreation(
          stubExistsTemplateDirectory,
          mockCreateTemplatesDirectory,
          stubCanCreateTemplatesDirectory);

      // Act
      handleTemplateDirectoryCreation();

      // Assert
      expect(mockCreateTemplatesDirectory.callsCounter, isZero);
    });

    test(
        "existsTemplateDirectory returns false, canCreateTemplateDirectory returns true, should call createTemplatesDirectory once",
        () {
      // Arrange
      final stubExistsTemplateDirectory = StubExistsTemplateDirectory(false);
      final mockCreateTemplatesDirectory = MockCreateTemplateDirectory();
      final stubCanCreateTemplatesDirectory =
          StubCanCreateTemplatesDirectory(true);
      final handleTemplateDirectoryCreation = HandleTemplateDirectoryCreation(
          stubExistsTemplateDirectory,
          mockCreateTemplatesDirectory,
          stubCanCreateTemplatesDirectory);

      // Act
      handleTemplateDirectoryCreation();

      // Assert
      expect(mockCreateTemplatesDirectory.callsCounter, 1);
    });
  });
}
