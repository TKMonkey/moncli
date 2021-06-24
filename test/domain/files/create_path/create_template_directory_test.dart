import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/create_path/i_create_template_directory.dart';
import 'package:moncli/src/domain/files/i_create_path.dart';
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

class MockCreatePath implements ICreatePath {
  String? _path;
  bool? _overwrite;
  bool? _isFile;

  @override
  void call(String path, {required bool overwrite, required bool isFile}) {
    _path = path;
    _overwrite = overwrite;
    _isFile = isFile;
  }

  String? get path => _path;

  bool? get overwrite => _overwrite;

  bool? get isFile => _isFile;
}

void main() {
  group("CreateTemplatesDirectory", () {
    test(
        "should call createPath with pathConstants.templateFolderPath, overwrite false and isFile false",
        () {
      // Arrange
      final pathConstants = MockPathConstants();
      final createPath = MockCreatePath();
      final createTemplatesDirectory =
          CreateTemplatesDirectory(pathConstants, createPath);

      // Act
      createTemplatesDirectory();

      // Assert
      expect(createPath.path, pathConstants.templateFolderPath);
      expect(createPath.overwrite, isFalse);
      expect(createPath.isFile, isFalse);
    });
  });
}
