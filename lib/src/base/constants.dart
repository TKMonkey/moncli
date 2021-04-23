const env = 'TEST';

final mainDirectory = env.isEmpty ? '' : 'filetest';

final pubspecFileName = env.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';
final outputPubPath = env.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec-output.yaml';
final templateFolderPath = env.isEmpty ? 'templates' : '$mainDirectory/templates';

const assetsTemplateName = 'assets_manager_config.yaml';
const assetsTemplatePath = 'lib/src/templates/$assetsTemplateName';
final assetsOutputPath = '$templateFolderPath/$assetsTemplateName';
