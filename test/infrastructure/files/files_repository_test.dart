import 'package:moncli/src/infrastructure/files/files_repository.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class MockFileDataSource implements IFileDataSource {
  String? _createDirectoryPath;
  String? _createFilePath;
  String? _existsPath;
  String? _copySourcePath;
  String? _copyDestinationPath;

  final bool _existsPathReturn;

  MockFileDataSource(this._existsPathReturn);

  @override
  void createDirectory(String path) {
    _createDirectoryPath = path;
  }

  @override
  void createFile(String path) {
    _createFilePath = path;
  }

  @override
  bool existsPath(String path) {
    _existsPath = path;
    return _existsPathReturn;
  }

  @override
  void copyFile(String sourcePath, String destinationPath) {
    _copySourcePath = sourcePath;
    _copyDestinationPath = destinationPath;
  }

  String? get createDirectoryPath => _createDirectoryPath;

  String? get createFilePath => _createFilePath;

  String? get existsPathString => _existsPath;

  String? get copySourcePath => _copySourcePath;

  String? get copyDestinationPath => _copyDestinationPath;
}

class MockUserPromptDataSource implements IUserPromptDataSource {
  final bool _trueOrFalseReturn;
  String? _question;

  MockUserPromptDataSource(this._trueOrFalseReturn);

  @override
  bool getTrueOrFalse(String question) {
    _question = question;
    return _trueOrFalseReturn;
  }

  String? get question => _question;
}

void main() {
  group("FileRepository", () {
    group("existsPath", () {
      test("Should call filesDataSource.existsPath with received path", () {
        // Arrange
        final fileDataSource = MockFileDataSource(true);
        final userPromptDataSource = MockUserPromptDataSource(true);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        // ignore: cascade_invocations
        fileRepository.existsPath("aPath");

        // Assert
        expect(fileDataSource.existsPathString, "aPath");
      });

      test("filesDataSource.existsPath returns true, Should return true", () {
        // Arrange
        final fileDataSource = MockFileDataSource(true);
        final userPromptDataSource = MockUserPromptDataSource(true);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        final existsPath = fileRepository.existsPath("aPath");

        // Assert
        expect(existsPath, isTrue);
      });

      test("filesDataSource.existsPath returns false, Should return false", () {
        // Arrange
        final fileDataSource = MockFileDataSource(false);
        final userPromptDataSource = MockUserPromptDataSource(true);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        final existsPath = fileRepository.existsPath("aPath");

        // Assert
        expect(existsPath, isFalse);
      });
    });

    group("canCreatePath", () {
      test(
          "Should call userPromptDataSource.canCreatePath with received boldStatement",
          () {
        // Arrange
        final fileDataSource = MockFileDataSource(true);
        final userPromptDataSource = MockUserPromptDataSource(true);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        // ignore: cascade_invocations
        fileRepository.canCreatePath("path", "aBoldStatement");

        // Assert
        expect(userPromptDataSource.question, contains("aBoldStatement"));
      });

      test("userPromptDataSource returns true, Should return true", () {
        // Arrange
        final fileDataSource = MockFileDataSource(true);
        final userPromptDataSource = MockUserPromptDataSource(true);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        final canCreatePath =
            fileRepository.canCreatePath("aPath", "aBoldStatement");

        // Assert
        expect(canCreatePath, true);
      });

      test("userPromptDataSource returns true, Should return false", () {
        // Arrange
        final fileDataSource = MockFileDataSource(true);
        final userPromptDataSource = MockUserPromptDataSource(false);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        final canCreatePath =
            fileRepository.canCreatePath("aPath", "aBoldStatement");

        // Assert
        expect(canCreatePath, false);
      });
    });

    group("createDirectory", () {
      test("Should call filesDataSource.createDirectory with received path",
          () {
        // Arrange
        final fileDataSource = MockFileDataSource(true);
        final userPromptDataSource = MockUserPromptDataSource(false);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        // ignore: cascade_invocations
        fileRepository.createDirectory("aPath");

        // Assert
        expect(fileDataSource.createDirectoryPath, "aPath");
      });
    });

    group("createFile", () {
      test(
          "overwrite true, existsPath true, should call filesDataSource.createFile with path",
          () {
        // Arrange
        final fileDataSource = MockFileDataSource(true);
        final userPromptDataSource = MockUserPromptDataSource(false);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        // ignore: cascade_invocations
        fileRepository.createFile("aPath", overwrite: true);

        // Assert
        expect(fileDataSource.createFilePath, "aPath");
      });

      test(
          "overwrite true, existsPath false, should call filesDataSource.createFile with path",
          () {
        // Arrange
        final fileDataSource = MockFileDataSource(false);
        final userPromptDataSource = MockUserPromptDataSource(false);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        // ignore: cascade_invocations
        fileRepository.createFile("aPath", overwrite: true);

        // Assert
        expect(fileDataSource.createFilePath, "aPath");
      });

      test(
          "overwrite false, existsPath true, should NOT call filesDataSource.createFile with path",
          () {
        // Arrange
        final fileDataSource = MockFileDataSource(true);
        final userPromptDataSource = MockUserPromptDataSource(false);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        // ignore: cascade_invocations
        fileRepository.createFile("aPath", overwrite: false);

        // Assert
        expect(fileDataSource.createFilePath, null);
      });

      test(
          "overwrite false, existsPath false, should call filesDataSource.createFile with path",
          () {
        // Arrange
        final fileDataSource = MockFileDataSource(false);
        final userPromptDataSource = MockUserPromptDataSource(false);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        // ignore: cascade_invocations
        fileRepository.createFile("aPath", overwrite: false);

        // Assert
        expect(fileDataSource.createFilePath, "aPath");
      });
    });

    group("copyFile", () {
      test(
          "should call filesDataSource.copyFile with sourcePath and destinationPath",
          () {
        // Arrange
        final fileDataSource = MockFileDataSource(false);
        final userPromptDataSource = MockUserPromptDataSource(false);
        final fileRepository =
            FileRepository(fileDataSource, userPromptDataSource);

        // Act
        // ignore: cascade_invocations
        fileRepository.copyFile("sourcePath", "destinationPath");

        // Assert
        expect(fileDataSource.copySourcePath, "sourcePath");
        expect(fileDataSource.copyDestinationPath, "destinationPath");
      });
    });
  });
}
