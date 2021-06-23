import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_exists/i_exists_template_directory.dart';
import 'package:moncli/src/domain/files/i_exists_path.dart';
import 'package:test/test.dart';

class StubPathConstants implements IPathConstants {
  @override
  // TODO: implement assetsOutputPath
  String get assetsOutputPath => throw UnimplementedError();

  @override
  // TODO: implement assetsTemplateName
  String get assetsTemplateName => throw UnimplementedError();

  @override
  // TODO: implement assetsTemplatePath
  String get assetsTemplatePath => throw UnimplementedError();

  @override
  // TODO: implement mainDirectory
  String get mainDirectory => throw UnimplementedError();

  @override
  // TODO: implement outputPubPath
  String get outputPubPath => throw UnimplementedError();

  @override
  // TODO: implement pubspecFileName
  String get pubspecFileName => throw UnimplementedError();

  @override
  // TODO: implement slash
  String get slash => throw UnimplementedError();

  @override
  String get templateFolderPath => "templateFolderPath";
}

class FakeExistsPath implements IExistsPath {
  final bool _existsPathReturn;
  String? _path;

  FakeExistsPath(this._existsPathReturn);

  @override
  bool call(String path) {
    _path = path;
    return _existsPathReturn;
  }

  String? get path => _path;
}

void main() {
  group("ExistsTemplateDirectory", () {
    test("should call existsPath with pathConstants.templateFolderPath", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final mockExistsPath = FakeExistsPath(true);
      final existsTemplateDirectory =
          ExistsTemplateDirectory(mockExistsPath, stubPathConstants);

      // Act
      existsTemplateDirectory();

      // Assert
      expect(mockExistsPath.path, stubPathConstants.templateFolderPath);
    });

    test("existsPath returns true, should return true", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final stubExistsPath = FakeExistsPath(true);
      final existsTemplateDirectory =
          ExistsTemplateDirectory(stubExistsPath, stubPathConstants);

      // Act
      final doesExistTemplateDirectory = existsTemplateDirectory();

      // Assert
      expect(doesExistTemplateDirectory, isTrue);
    });

    test("existsPath returns false, should return false", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final stubExistsPath = FakeExistsPath(false);
      final existsTemplateDirectory =
          ExistsTemplateDirectory(stubExistsPath, stubPathConstants);

      // Act
      final doesExistTemplateDirectory = existsTemplateDirectory();

      // Assert
      expect(doesExistTemplateDirectory, isFalse);
    });
  });
}
