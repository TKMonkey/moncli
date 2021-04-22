final environment = 'TEST';

final mainDirectory = environment.isEmpty ? '' : 'filetest';

final pubspecDirectory =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';

final outputDirectory =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec-output.yaml';

final templateFolder = environment.isEmpty ? 'templates' : '$mainDirectory/templates';
