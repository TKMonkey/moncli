import 'package:moncli/src/domain/files/i_exists_path.dart';
import 'package:moncli/src/domain/files/i_files_repository.dart';
import 'package:test/test.dart';

class MockFileRepository implements IFilesRepository {
  final bool _existsPathReturn;
  String? _existsPathPath;

  MockFileRepository(this._existsPathReturn);

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
    // TODO: implement createDirectory
  }

  @override
  void createFile(String path, {required bool overwrite}) {
    // TODO: implement createFile
  }

  @override
  bool existsPath(String path) {
    _existsPathPath = path;
    return _existsPathReturn;
  }

  String? get existsPathPath => _existsPathPath;
}

void main() {
  group("ExistsPath", () {
    test("path exists, should return true", () {
      // Arrange
      final fileRepository = MockFileRepository(true);
      final existsPath = ExistsPath(fileRepository);

      // Act
      final doesFileExist = existsPath("aPath");

      // Assert
      expect(doesFileExist, isTrue);
    });

    test("path does not exist, should return false", () {
      // Arrange
      final fileRepository = MockFileRepository(false);
      final existsPath = ExistsPath(fileRepository);

      // Act
      final doesFileExist = existsPath("aPath");

      // Assert
      expect(doesFileExist, isFalse);
    });

    test("should call fileRepository.existsPath with received path", () {
      // Arrange
      final fileRepository = MockFileRepository(false);
      final existsPath = ExistsPath(fileRepository);

      // Act
      existsPath("aPath");

      // Assert
      expect(fileRepository.existsPathPath, "aPath");
    });
  });
}
