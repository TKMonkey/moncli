import 'package:injectable/injectable.dart';

const env = 'TEST';

final mainDirectory = env.isEmpty ? '' : 'filetest';
final slash = mainDirectory.isNotEmpty ? '/' : '';

final pubspecFileName =
    env.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';
final outputPubPath =
    env.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec-output.yaml';
final templateFolderPath =
    env.isEmpty ? 'templates' : '$mainDirectory/templates';

const assetsTemplateName = 'assets_manager_config.yaml';
const assetsTemplatePath = 'lib/src/templates/$assetsTemplateName';
final assetsOutputPath = '$templateFolderPath/$assetsTemplateName';

abstract class IPathConstants {
  String get mainDirectory;

  String get slash;

  String get pubspecFileName;

  String get outputPubPath;

  String get templateFolderPath;

  String get assetsTemplateName;

  String get assetsTemplatePath;

  String get assetsOutputPath;
}

@LazySingleton(as: IPathConstants)
class PathConstants implements IPathConstants {
  final _env = "TEST";

  PathConstants();

  @override
  String get assetsOutputPath => '$templateFolderPath/$assetsTemplateName';

  @override
  String get assetsTemplateName => 'assets_manager_config.yaml';

  @override
  String get assetsTemplatePath => 'lib/src/templates/$assetsTemplateName';

  @override
  String get mainDirectory => _env.isEmpty ? '' : 'filetest';

  @override
  String get outputPubPath =>
      _env.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec-output.yaml';

  @override
  String get pubspecFileName =>
      _env.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';

  @override
  String get slash => mainDirectory.isNotEmpty ? '/' : '';

  @override
  String get templateFolderPath =>
      _env.isEmpty ? 'templates' : '$mainDirectory/templates';
}
