import 'package:args/command_runner.dart';
import 'package:moncli/src/command/comand.dart';
import 'package:moncli/src/utils/utils.dart';

import 'command_line_app.dart';

class Moncli with CommandLineApp {
  Moncli() {
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

    _configureCommand();
  }

  void _configureCommand() {
    runner.addCommand(PubCommand());
  }

  @override
  String get name => 'Moncli';

  @override
  String get version => 'Version: 0.0.1';

  @override
  String get author => 'The Koding Monkey';

  @override
  String get license => 'MIT license';

  @override
  String get url => 'https://github.com/TKMonkey/moncli';

  @override
  void addArgument(String argumentName, String helpMessage, bool isActive) {}

  @override
  Future<void> runCommand(Iterable<String> arguments) async {
    if (!hasCommand(arguments)) {
      executeOptions(arguments);
    } else {
      await runner.run(arguments).catchError(
        (error) {
          if (error is UsageException) {
            logger
              ..err(error.message)
              ..info(error.usage);
          } else if (error is FormatException) {
            logger.err(error.message);
          } else {
            throw error;
          }
        },
      );
    }
  }
}
