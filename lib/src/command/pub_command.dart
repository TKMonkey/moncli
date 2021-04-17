import 'package:args/command_runner.dart';
import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/command/pub_subcommand/pub_subcommand.dart';
import 'package:moncli/src/utils/utils.dart';

class PubCommand extends CommandBase {
  PubCommand() {
    addSubcommand(InstallCommand());
  }

  @override
  String get description =>
      'Manipulate the pubspec.yaml, according to the subcommand(options)';

  @override
  String get name => 'pub';

  @override
  String get invocation => 'moncli pub ${Logger.yellow('[subCommand]')}';
}
