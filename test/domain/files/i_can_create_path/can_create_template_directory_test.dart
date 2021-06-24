import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_can_create_path.dart';
import 'package:moncli/src/domain/files/i_can_create_path/i_can_create_template_directory.dart';
import 'package:test/test.dart';

class StubPathConstants implements IPathConstants {
  // TODO: implement assetsTemplateName
  @override
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
  // TODO: implement templateFolderPath
  String get templateFolderPath => "templateFolderPath";
}

class FakeCanCreatePath implements ICanCreatePath {
  String? _path;
  String? _boldStatement;
  final bool _canCreatePathReturn;

  FakeCanCreatePath(this._canCreatePathReturn);

  @override
  bool call(String path, String boldStatement) {
    _path = path;
    _boldStatement = boldStatement;

    return _canCreatePathReturn;
  }

  String? get path => _path;

  String? get boldStatement => _boldStatement;
}

void main() {
  group("CanCreateTemplateDirectory", () {
    test(
        "should call canCraetePath with pathConstants.assetsOutputPath and 'templates directory'",
        () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final mockCanCreatePath = FakeCanCreatePath(true);
      final canCreateTemplatesDirectory =
          CanCreateTemplatesDirectory(mockCanCreatePath, stubPathConstants);

      // Act
      canCreateTemplatesDirectory();

      // Assert
      expect(mockCanCreatePath.path, stubPathConstants.templateFolderPath);
      expect(mockCanCreatePath.boldStatement, "templates directory");
    });

    test("canCreatePath returns true, should return true'", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final stubCanCreatePath = FakeCanCreatePath(true);
      final canCreateTemplatesDirectory =
          CanCreateTemplatesDirectory(stubCanCreatePath, stubPathConstants);

      // Act
      final canCreate = canCreateTemplatesDirectory();

      // Assert
      expect(canCreate, isTrue);
    });

    test("canCreatePath returns true, should return true'", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final stubCanCreatePath = FakeCanCreatePath(false);
      final canCreateTemplatesDirectory =
          CanCreateTemplatesDirectory(stubCanCreatePath, stubPathConstants);

      // Act
      final canCreate = canCreateTemplatesDirectory();

      // Assert
      expect(canCreate, isFalse);
    });
  });
}
