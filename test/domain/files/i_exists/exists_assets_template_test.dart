import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_exists/i_exists_assets_template.dart';
import 'package:moncli/src/domain/files/i_exists_path.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class StubPathConstants implements IPathConstants {
  @override
  // TODO: implement assetsOutputPath
  String get assetsOutputPath => "assetsOutputPath";

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
  // TODO: implement templateFolderPath
  String get templateFolderPath => throw UnimplementedError();
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
  group("ExistsAssetsTemplate", () {
    test("should call existsPath with pathConstants.assetsOutputPath", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final mockExistsPath = FakeExistsPath(true);
      final existsAssetsTemplate =
          ExistsAssetsTemplate(mockExistsPath, stubPathConstants);

      // Act
      existsAssetsTemplate();

      // Assert
      expect(mockExistsPath.path, stubPathConstants.assetsOutputPath);
    });

    test("existsPath returns true, should return true", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final stubExistsPath = FakeExistsPath(true);
      final existsAssetsTemplate =
          ExistsAssetsTemplate(stubExistsPath, stubPathConstants);

      // Act
      final doesExistAssetTemplate = existsAssetsTemplate();

      // Assert
      expect(doesExistAssetTemplate, isTrue);
    });

    test("existsPath returns false, should return false", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final stubExistsPath = FakeExistsPath(false);
      final existsAssetsTemplate =
          ExistsAssetsTemplate(stubExistsPath, stubPathConstants);

      // Act
      final doesExistAssetTemplate = existsAssetsTemplate();

      // Assert
      expect(doesExistAssetTemplate, isFalse);
    });
  });
}
