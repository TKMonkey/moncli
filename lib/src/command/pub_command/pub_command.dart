import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/command/pub_command/subcommand_export.dart';
import 'package:moncli/src/utils/utils.dart';

class PubCommand extends CommandBase {
  PubCommand() {
    addSubcommand(InstallSubCommand());
    addSubcommand(AssetManagerSubCommand());
    addSubcommand(RemoveSubCommand());
    addSubcommand(RunScriptSubCommand());
    addSubcommand(UnusedPkgSubCommand());
  }

  @override
  String get description =>
      'Manipulate the pubspec.yaml, according to the subcommand(options)';

  @override
  String get name => 'pub';

  @override
  String get invocation => 'moncli pub ${yellow('[subCommand]')}';
}
