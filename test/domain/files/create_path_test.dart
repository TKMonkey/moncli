import 'package:moncli/src/domain/files/i_create_path.dart';
import 'package:moncli/src/domain/files/i_exists_path.dart';
import 'package:moncli/src/domain/files/i_files_repository.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

class MockFileRepository implements IFilesRepository {
  String? _createFilePath;
  bool? _createFileOverwrite;

  String? _createDirectoryPath;

  @override
  bool canCreatePath(String path, String boldStatement) {
    // TODO: implement canCreatePath
    throw UnimplementedError();
  }

  @override
  void copyFile(String sourcePath, String destinationPath) {
    // TODO: implement copyFile
  }

  @override
  void createDirectory(String path) {
    _createDirectoryPath = path;
  }

  @override
  void createFile(String path, {required bool overwrite}) {
    _createFilePath = path;
    _createFileOverwrite = overwrite;
  }

  @override
  bool existsPath(String path) {
    // TODO: implement existsPath
    throw UnimplementedError();
  }

  String? get createFilePath => _createFilePath;

  bool? get createFileOverwrite => _createFileOverwrite;

  String? get createDirectoryPath => _createDirectoryPath;
}

class MockExistsPath implements IExistsPath {
  final bool _existsPathReturn;

  MockExistsPath(this._existsPathReturn);

  @override
  bool call(String path) {
    return _existsPathReturn;
  }
}

void main() {
  group("CreatePath", () {
    test(
        "overwrite true, isFile true, existsPath true, should call filesRepository.createFile with received parameters",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(true);
      final createPath = CreatePath(existsPath, fileRepository);

      // Act
      createPath("aPath", overwrite: true, isFile: true);

      // Assert
      expect(fileRepository.createFilePath, "aPath");
      expect(fileRepository.createFileOverwrite, true);
    });

    test(
        "overwrite true, isFile true, existsPath false, should call filesRepository.createFile with received parameters",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(false);
      final createPath = CreatePath(existsPath, fileRepository);

      // Act
      createPath("aPath", overwrite: true, isFile: true);

      // Assert
      expect(fileRepository.createFilePath, "aPath");
      expect(fileRepository.createFileOverwrite, true);
    });

    test(
        "overwrite true, isFile false, existsPath true, should call filesRepository.createDirectory with received parameters",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(true);
      final createPath = CreatePath(existsPath, fileRepository);

      // Act
      createPath("aPath", overwrite: true, isFile: false);

      // Assert
      expect(fileRepository.createDirectoryPath, "aPath");
    });

    test(
        "overwrite true, isFile false, existsPath false, should call filesRepository.createDirectory with received parameters",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(false);
      final createPath = CreatePath(existsPath, fileRepository);

      // Act
      createPath("aPath", overwrite: true, isFile: false);

      // Assert
      expect(fileRepository.createDirectoryPath, "aPath");
    });

    test(
        "overwrite false, isFile true, existsPath true, should NOT call filesRepository.createFile with received parameters",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(true);
      final createPath = CreatePath(existsPath, fileRepository);

      // Act
      createPath("aPath", overwrite: false, isFile: true);

      // Assert
      expect(fileRepository.createFilePath, null);
      expect(fileRepository.createFileOverwrite, null);
    });

    test(
        "overwrite false, isFile true, existsPath false, should call filesRepository.createFile with received parameters",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(false);
      final createPath = CreatePath(existsPath, fileRepository);

      // Act
      createPath("aPath", overwrite: false, isFile: true);

      // Assert
      expect(fileRepository.createFilePath, "aPath");
      expect(fileRepository.createFileOverwrite, true);
    });

    test(
        "overwrite false, isFile false, existsPath true, should NOT call filesRepository.createDirectory with received parameters",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(true);
      final createPath = CreatePath(existsPath, fileRepository);

      // Act
      createPath("aPath", overwrite: false, isFile: false);

      // Assert
      expect(fileRepository.createDirectoryPath, null);
    });

    test(
        "overwrite false, isFile false, existsPath false, should call filesRepository.createDirectory with received parameters",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(false);
      final createPath = CreatePath(existsPath, fileRepository);

      // Act
      createPath("aPath", overwrite: false, isFile: false);

      // Assert
      expect(fileRepository.createDirectoryPath, "aPath");
    });
  });
}
