import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/command/pub_command/subcommand_export.dart';
import 'package:moncli/src/utils/utils.dart';

class PubCommand extends CommandBase {
  PubCommand() {
    addSubcommand(AssetManagerSubCommand());
    addSubcommand(InstallSubCommand());
    addSubcommand(RemoveSubCommand());
    addSubcommand(RunScriptSubCommand());
    addSubcommand(SortSubCommand());
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
