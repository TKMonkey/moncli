import 'package:moncli/src/domain/files/copy_path/i_copy_assets_template.dart';
import 'package:moncli/src/domain/files/i_can_create_path/i_can_create_assets_template.dart';
import 'package:moncli/src/domain/files/i_exists/i_exists_template_directory.dart';
import 'package:moncli/src/domain/files/i_handle_assets_template_creation.dart';
import 'package:moncli/src/domain/files/i_handle_template_directory_creation.dart';
import 'package:test/test.dart';

class MockCopyAssetsTemplate implements ICopyAssetsTemplate {
  int _callsCounter = 0;

  @override
  void call({bool overwrite = false}) {
    _callsCounter++;
  }

  int get callsCounter => _callsCounter;
}

class StubCanCreateAssetsTemplate implements ICanCreateAssetsTemplate {
  final bool _valueToReturn;

  StubCanCreateAssetsTemplate(this._valueToReturn);

  @override
  bool call() {
    return _valueToReturn;
  }
}

class StubExistsTemplateDirectory implements IExistsTemplateDirectory {
  final bool _valueToReturn;

  StubExistsTemplateDirectory(this._valueToReturn);

  @override
  bool call() {
    return _valueToReturn;
  }
}

class MockHandleTemplateDirectoryCreation
    implements IHandleTemplateDirectoryCreation {
  int _callsCounter = 0;

  @override
  void call() {
    _callsCounter++;
  }

  int get callsCounter => _callsCounter;
}

void main() {
  group("HandleAssetsTemplateCreation", () {
    group("canCreateAssetsTemplate returns false", () {
      test("should not call handleTemplateDirectoryCreation", () {
        // Arrange
        final stubCopyAssetsTemplate = MockCopyAssetsTemplate();
        final stubCanCreateAssetsTemplate = StubCanCreateAssetsTemplate(false);
        final stubExistsTemplateDirectory = StubExistsTemplateDirectory(true);
        final mockHandleTemplateDirectoryCreation =
            MockHandleTemplateDirectoryCreation();
        final handleAssetsTemplateCreation = HandleAssetsTemplateCreation(
            stubCopyAssetsTemplate,
            stubCanCreateAssetsTemplate,
            stubExistsTemplateDirectory,
            mockHandleTemplateDirectoryCreation);

        // Act
        handleAssetsTemplateCreation(overwrite: true);

        // Assert
        expect(mockHandleTemplateDirectoryCreation.callsCounter, isZero);
      });

      test("should not call copyAssetsTemplate", () {
        // Arrange
        final mockCopyAssetsTemplate = MockCopyAssetsTemplate();
        final stubCanCreateAssetsTemplate = StubCanCreateAssetsTemplate(false);
        final stubExistsTemplateDirectory = StubExistsTemplateDirectory(true);
        final stubHandleTemplateDirectoryCreation =
            MockHandleTemplateDirectoryCreation();
        final handleAssetsTemplateCreation = HandleAssetsTemplateCreation(
            mockCopyAssetsTemplate,
            stubCanCreateAssetsTemplate,
            stubExistsTemplateDirectory,
            stubHandleTemplateDirectoryCreation);

        // Act
        handleAssetsTemplateCreation(overwrite: true);

        // Assert
        expect(mockCopyAssetsTemplate.callsCounter, isZero);
      });
    });

    group("canCreateAssetsTemplate returns true", () {
      test("should call handleTemplateDirectoryCreation once", () {
        // Arrange
        final stubCopyAssetsTemplate = MockCopyAssetsTemplate();
        final stubCanCreateAssetsTemplate = StubCanCreateAssetsTemplate(true);
        final stubExistsTemplateDirectory = StubExistsTemplateDirectory(true);
        final mockHandleTemplateDirectoryCreation =
            MockHandleTemplateDirectoryCreation();
        final handleAssetsTemplateCreation = HandleAssetsTemplateCreation(
            stubCopyAssetsTemplate,
            stubCanCreateAssetsTemplate,
            stubExistsTemplateDirectory,
            mockHandleTemplateDirectoryCreation);

        // Act
        handleAssetsTemplateCreation(overwrite: true);

        // Assert
        expect(mockHandleTemplateDirectoryCreation.callsCounter, 1);
      });

      test(
          "existsTemplateDirectory returns false, should not call copyAssetsTemplate",
          () {
        // Arrange
        final mockCopyAssetsTemplate = MockCopyAssetsTemplate();
        final stubCanCreateAssetsTemplate = StubCanCreateAssetsTemplate(true);
        final stubExistsTemplateDirectory = StubExistsTemplateDirectory(false);
        final mockHandleTemplateDirectoryCreation =
            MockHandleTemplateDirectoryCreation();
        final handleAssetsTemplateCreation = HandleAssetsTemplateCreation(
            mockCopyAssetsTemplate,
            stubCanCreateAssetsTemplate,
            stubExistsTemplateDirectory,
            mockHandleTemplateDirectoryCreation);

        // Act
        handleAssetsTemplateCreation(overwrite: true);

        // Assert
        expect(mockCopyAssetsTemplate.callsCounter, isZero);
      });

      test(
          "existsTemplateDirectory returns true, should call copyAssetsTemplate once",
          () {
        // Arrange
        final mockCopyAssetsTemplate = MockCopyAssetsTemplate();
        final stubCanCreateAssetsTemplate = StubCanCreateAssetsTemplate(true);
        final stubExistsTemplateDirectory = StubExistsTemplateDirectory(true);
        final mockHandleTemplateDirectoryCreation =
            MockHandleTemplateDirectoryCreation();
        final handleAssetsTemplateCreation = HandleAssetsTemplateCreation(
            mockCopyAssetsTemplate,
            stubCanCreateAssetsTemplate,
            stubExistsTemplateDirectory,
            mockHandleTemplateDirectoryCreation);

        // Act
        handleAssetsTemplateCreation(overwrite: true);

        // Assert
        expect(mockCopyAssetsTemplate.callsCounter, 1);
      });
    });
  });
}
