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

  void executeOptions(Iterable<String> arguments) async {
    final parser = runner.argParser;
    final results = parser.parse(arguments);

    if (results.wasParsed('help') || arguments.isEmpty) {
      printerr.w(usage);
    }

    if (results.wasParsed('printer')) {
      printInformation();
    }

    if (results.wasParsed('version')) {
      printerr.w(version);
    }
  }

  void printInformation() {
    printerr
      ..w('\n$printer\n')
      ..yellow(description)
      ..w('$name $version')
      ..w('Author: $author')
      ..w('$license')
      ..w('\nVisit here: $url');
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
