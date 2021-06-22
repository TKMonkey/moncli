import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_can_create_path.dart';
import 'package:moncli/src/domain/files/i_can_create_path/i_can_create_assets_template.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

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

class FakeCanCreatePath implements ICanCreatePath {
  final bool _canCreatePathReturn;
  String? _path;
  String? _boldStatement;

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
  group("CanCreateAssetsTemplate", () {
    test(
        "should call canCreatePath with pathConstants.assetsOutputPath and 'assets template file' as boldStatement",
        () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final mockCanCreatePath = FakeCanCreatePath(true);
      final canCreateAssetsTemplate =
          CanCreateAssetsTemplate(mockCanCreatePath, stubPathConstants);

      // Act
      canCreateAssetsTemplate();

      // Assert
      expect(mockCanCreatePath.path, stubPathConstants.assetsOutputPath);
    });

    test("canCreatePath returns true, should return true", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final stubCanCreatePath = FakeCanCreatePath(true);
      final canCreateAssetsTemplate =
          CanCreateAssetsTemplate(stubCanCreatePath, stubPathConstants);

      // Act
      final canCreateAssetsTemplateReturn = canCreateAssetsTemplate();

      // Assert
      expect(canCreateAssetsTemplateReturn, isTrue);
    });

    test("canCreatePath returns false, should return false", () {
      // Arrange
      final stubPathConstants = StubPathConstants();
      final stubCanCreatePath = FakeCanCreatePath(false);
      final canCreateAssetsTemplate =
          CanCreateAssetsTemplate(stubCanCreatePath, stubPathConstants);

      // Act
      final canCreateAssetsTemplateReturn = canCreateAssetsTemplate();

      // Assert
      expect(canCreateAssetsTemplateReturn, isFalse);
    });
  });
}
