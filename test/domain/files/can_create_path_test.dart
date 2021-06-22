import 'package:moncli/src/domain/files/i_can_create_path.dart';
import 'package:moncli/src/domain/files/i_files_repository.dart';
import 'package:test/test.dart';

class MockFileRepository implements IFilesRepository {
  final bool _canCreatePath;
  String? _canCreatePathPath;
  String? _canCreatePathBoldStatement;

  MockFileRepository({bool canCreatePath = true})
      : _canCreatePath = canCreatePath;

  @override
  bool canCreatePath(String path, String boldStatement) {
    _canCreatePathPath = path;
    _canCreatePathBoldStatement = boldStatement;

    return _canCreatePath;
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
    // TODO: implement existsPath
    throw UnimplementedError();
  }

  String? get canCreatePathPath => _canCreatePathPath;

  String? get canCreatePathBoldStatement => _canCreatePathBoldStatement;
}

void main() {
  group("CanCreatePath", () {
    test("should call filesRepository with received path and boldStatement",
        () {
      // Arrange
      final fileRepository = MockFileRepository();
      final canCreatePath = CanCreatePath(fileRepository);

      // Act
      canCreatePath("aPath", "aBoldStatement");

      // Assert
      expect(fileRepository.canCreatePathPath, "aPath");
      expect(fileRepository.canCreatePathBoldStatement, "aBoldStatement");
    });
  });
}
