final environment = 'TEST';

final mainDirectory = environment.isEmpty ? '' : 'filetest';

final pubspecFile =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';

final outputFile =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec-output.yaml';

final templateFolder = environment.isEmpty ? 'templates' : '$mainDirectory/templates';

const assetsPath = 'lib/src/templates/$assetsTemplateName';

const assetsTemplateName = 'assets_manager_config.yaml';
