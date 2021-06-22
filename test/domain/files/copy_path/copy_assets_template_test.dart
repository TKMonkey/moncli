import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/copy_path/i_copy_assets_template.dart';
import 'package:moncli/src/domain/files/i_copy_path.dart';
import 'package:test/test.dart';

class MockPathConstants implements IPathConstants {
  @override
  // TODO: implement assetsOutputPath
  String get assetsOutputPath => throw UnimplementedError();

  @override
  // TODO: implement assetsTemplateName
  String get assetsTemplateName => throw UnimplementedError();

  @override
  // TODO: implement assetsTemplatePath
  String get assetsTemplatePath => "assetsTemplatePath";

  @override
  // TODO: implement mainDirectory
  String get mainDirectory => throw UnimplementedError();

  @override
  // TODO: implement outputPubPath
  String get outputPubPath => "assetsOutputPath";

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

class MockCopyFile implements ICopyFile {
  String? _sourcePath;
  String? _destinationPath;
  bool? _overwrite;

  @override
  void call(String sourcePath, String destinationPath,
      {required bool overwrite}) {
    _sourcePath = sourcePath;
    _destinationPath = destinationPath;
    _overwrite = overwrite;
  }

  String? get sourcePath => _sourcePath;

  String? get destinationPath => _destinationPath;

  bool? get overwrite => _overwrite;
}

void main() {
  group("CopyAssetsTemplate", () {
    test(
        "overwrite true, should call copyFile with pathConstants.assetsTemplatePath, pathConstants.assetsOutputPath and received overwrite",
        () {
      // Arrange
      final pathConstants = PathConstants();
      final copyFile = MockCopyFile();
      final copyAssetsTemplate = CopyAssetsTemplate(pathConstants, copyFile);

      // Act
      copyAssetsTemplate(overwrite: true);

      // Assert
      expect(copyFile.sourcePath, pathConstants.assetsTemplatePath);
      expect(copyFile.destinationPath, pathConstants.assetsOutputPath);
      expect(copyFile.overwrite, isTrue);
    });

    test(
        "overwrite false, should call copyFile with pathConstants.assetsTemplatePath, pathConstants.assetsOutputPath and received overwrite",
        () {
      // Arrange
      final pathConstants = PathConstants();
      final copyFile = MockCopyFile();
      final copyAssetsTemplate = CopyAssetsTemplate(pathConstants, copyFile);

      // Act
      copyAssetsTemplate(overwrite: false);

      // Assert
      expect(copyFile.sourcePath, pathConstants.assetsTemplatePath);
      expect(copyFile.destinationPath, pathConstants.assetsOutputPath);
      expect(copyFile.overwrite, isFalse);
    });

    test(
        "overwrite defaultValue, should call copyFile with pathConstants.assetsTemplatePath, pathConstants.assetsOutputPath and false overwrite",
        () {
      // Arrange
      final pathConstants = PathConstants();
      final copyFile = MockCopyFile();
      final copyAssetsTemplate = CopyAssetsTemplate(pathConstants, copyFile);

      // Act
      copyAssetsTemplate();

      // Assert
      expect(copyFile.sourcePath, pathConstants.assetsTemplatePath);
      expect(copyFile.destinationPath, pathConstants.assetsOutputPath);
      expect(copyFile.overwrite, isFalse);
    });
  });
}
