import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_exists/i_existss_pub_spec.dart';
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
  String get pubspecFileName => "pubspecFileName";

  @override
  // TODO: implement slash
  String get slash => throw UnimplementedError();

  @override
  // TODO: implement templateFolderPath
  String get templateFolderPath => throw UnimplementedError();
}

class FakeExistsPath implements IExistsPath {
  String? _path;
  final bool _existsPathReturn;

  FakeExistsPath(this._existsPathReturn);

  @override
  bool call(String path) {
    _path = path;
    return _existsPathReturn;
  }

  String? get path => _path;
}

void main() {
  group("ExistsPubspec", () {
    test("should call existsPath fith pathConstants.pubspecFileName", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final mockExistsPath = FakeExistsPath(true);
      final existsPubspec = ExistsPubspec(mockExistsPath, stubPathConstants);

      // Act
      existsPubspec();

      // Assert
      expect(mockExistsPath.path, stubPathConstants.pubspecFileName);
    });

    test("existsPath returns true, should return true", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final mockExistsPath = FakeExistsPath(true);
      final existsPubspec = ExistsPubspec(mockExistsPath, stubPathConstants);

      // Act
      final doesExistPubSpec = existsPubspec();

      // Assert
      expect(doesExistPubSpec, isTrue);
    });

    test("existsPath returns false, should return false", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final mockExistsPath = FakeExistsPath(false);
      final existsPubspec = ExistsPubspec(mockExistsPath, stubPathConstants);

      // Act
      final doesExistPubSpec = existsPubspec();

      // Assert
      expect(doesExistPubSpec, isFalse);
    });
  });
}
