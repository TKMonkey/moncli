import 'package:args/command_runner.dart';
import 'package:moncli/src/utils/utils.dart';

mixin CommandLineApp {
  final CommandRunner runner = CommandRunner('Moncli', _description);

  static const _description = 'CLI package manager and template for Flutter.';

  late final String name;
  late final String version;
  late final String author;
  late final String license;
  late final String url;

  String get description => _description;

  String get usage => runner.usage;

  Future<void> runCommand(Iterable<String> arguments);

  void addArgument(String argumentName, String helpMessage, bool isActive);

  bool hasCommand(Iterable<String> arguments) =>
      runner.commands.keys.any((x) => arguments.contains(x));

  Future<void> executeOptions(Iterable<String> arguments) async {
    final parser = runner.argParser;
    final results = parser.parse(arguments);

    if (results.wasParsed('help') || arguments.isEmpty) {
      logger.info(usage);
    }

    if (results.wasParsed('printer')) {
      printInformation();
    }

    if (results.wasParsed('version')) {
      logger.info(version);
    }
  }

  void printInformation() {
    logger
      ..info('\n$printer\n')
      ..warn(description)
      ..info('$name $version')
      ..info('Author: $author')
      ..info(license)
      ..info('\nVisit here: $url');
  }

  String get printer => '''
      ███   ║███  ███████╗ ████╗   ██╗       ██████╗ ██╗      ██╗ 
      ██╚═██╗ ██  ██║  ██║ ██║██╗  ██║      ██╔════╝ ██║      ██║
      ██║ ██║ ██  ██║  ██║ ██║ ╚██ ██║  ╔╝  ██║      ██║      ██║
      ██║ ╚═╝ ██  ██║  ██║ ██║  ╚████║ ╔╝   ██║      ██║      ██║
      ██║     ██  ███████║ ██║    ███║      ╚██████╗ ███████╗ ██║
      ╚╝      ╚╝  ╚══════╝ ╚═╝    ╚══╝       ╚═════╝ ╚══════╝ ╚═╝                                             
''';
}
