import 'package:moncli/src/domain/files/i_copy_path.dart';
import 'package:moncli/src/domain/files/i_exists_path.dart';
import 'package:moncli/src/domain/files/i_files_repository.dart';
import 'package:test/test.dart';

class MockFileRepository implements IFilesRepository {
  String? _copySourcePath;
  String? _copyDestinationPath;

  @override
  bool canCreatePath(String path, String boldStatement) {
    // TODO: implement canCreatePath
    throw UnimplementedError();
  }

  @override
  void copyFile(String sourcePath, String destinationPath) {
    _copySourcePath = sourcePath;
    _copyDestinationPath = destinationPath;
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
    // TODO: implement existsPath
    throw UnimplementedError();
  }

  String? get copySourcePath => _copySourcePath;

  String? get copyDestinationPath => _copyDestinationPath;
}

class MockExistsPath implements IExistsPath {
  final bool _existsResult;

  MockExistsPath(this._existsResult);

  @override
  bool call(String path) {
    return _existsResult;
  }
}

void main() {
  group("CopyPath", () {
    test(
        "overwrite true and existsPath true, should call filesRepository.copyFile with received sourcePath and destinationPath",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(true);
      final copyPath = CopyPath(existsPath, fileRepository);

      // Act
      copyPath("sourcePath", "destinationPath", overwrite: true);

      // Assert
      expect(fileRepository.copySourcePath, "sourcePath");
      expect(fileRepository.copyDestinationPath, "destinationPath");
    });

    test(
        "overwrite true and existsPath false, should call filesRepository.copyFile with received sourcePath and destinationPath",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(false);
      final copyPath = CopyPath(existsPath, fileRepository);

      // Act
      copyPath("sourcePath", "destinationPath", overwrite: true);

      // Assert
      expect(fileRepository.copySourcePath, "sourcePath");
      expect(fileRepository.copyDestinationPath, "destinationPath");
    });

    test(
        "overwrite false and existsPath true, should NOT call filesRepository.copyFile",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(true);
      final copyPath = CopyPath(existsPath, fileRepository);

      // Act
      copyPath("sourcePath", "destinationPath", overwrite: false);

      // Assert
      expect(fileRepository.copySourcePath, null);
      expect(fileRepository.copyDestinationPath, null);
    });

    test(
        "overwrite false and existsPath false, should call filesRepository.copyFile with received sourcePath and destinationPath",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final existsPath = MockExistsPath(false);
      final copyPath = CopyPath(existsPath, fileRepository);

      // Act
      copyPath("sourcePath", "destinationPath", overwrite: false);

      // Assert
      expect(fileRepository.copySourcePath, "sourcePath");
      expect(fileRepository.copyDestinationPath, "destinationPath");
    });
  });
}
