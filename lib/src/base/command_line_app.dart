import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart' as dcli;

abstract class CommandLineApp {
  CommandLineApp({required this.runner}) {
    runner.argParser.addFlag(
      'printer',
      abbr: 'p',
      negatable: false,
      help: 'Print the information for the cli.',
    );

    runner.argParser.addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Print the version for the cli.',
    );
  }

  final CommandRunner runner;

  late final String name;
  late final String version;
  late final String author;
  late final String license;
  late final String url;
  late final String printer;

  late final String description;

  void runCommand(Iterable<String> arguments);

  void addArgument(String argumentName, String helpMessage, bool isActive);

  bool hasCommand(Iterable<String> arguments) =>
      runner.commands.keys.any((x) => arguments.contains(x));

  String get usage => runner.usage;

  void executeOptions(Iterable<String> arguments) async {
    final parser = runner.argParser;
    final results = parser.parse(arguments);

    if (results.wasParsed('help') || arguments.isEmpty) {
      dcli.printerr(usage);
    }

    if (results.wasParsed('printer')) {
      printInformation();
    }

    if (results.wasParsed('version')) {
      dcli.printerr(version);
    }
  }

  void printInformation() {
    dcli.printerr('\n$printer\n');
    dcli.printerr(dcli.yellow(description));
    dcli.printerr('$name $version');
    dcli.printerr('Author: $author');
    dcli.printerr('$license');
    dcli.printerr('\nVisit here: $url');
  }
}
