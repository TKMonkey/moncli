import 'package:args/command_runner.dart';
import 'package:moncli/src/command/comand.dart';
import 'package:moncli/src/utils/utils.dart';

import 'command_line_app.dart';

class Moncli extends CommandLineApp {
  Moncli() : super(runner: CommandRunner('Moncli', _description)) {
    _configureCommand();
  }

  static const _description = 'CLI package manager and template for Flutter.';

  void _configureCommand() {
    runner.addCommand(InstallCommand());
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
  String get printer => '''
      ███   ║███  ███████╗ ████╗   ██╗       ██████╗ ██╗      ██╗ 
      ██╚═██╗ ██  ██║  ██║ ██║██╗  ██║      ██╔════╝ ██║      ██║
      ██║ ██║ ██  ██║  ██║ ██║ ╚██ ██║  ╔╝  ██║      ██║      ██║
      ██║ ╚═╝ ██  ██║  ██║ ██║  ╚████║ ╔╝   ██║      ██║      ██║
      ██║     ██  ███████║ ██║    ███║      ╚██████╗ ███████╗ ██║
      ╚╝      ╚╝  ╚══════╝ ╚═╝    ╚══╝       ╚═════╝ ╚══════╝ ╚═╝                                             
''';

  @override
  String get description => _description;

  @override
  void addArgument(String argumentName, String helpMessage, bool isActive) {}

  @override
  void runCommand(Iterable<String> arguments) async {
    if (!hasCommand(arguments)) {
      executeOptions(arguments);
    } else {
      await runner.run(arguments).catchError(
        (error) {
          if (error is UsageException) {
            printerr
              ..red(error.message)
              ..w(error.usage);
          } else if (error is FormatException) {
            printerr..red(error.message);
          } else {
            throw error;
          }
        },
      );
    }
  }
}
