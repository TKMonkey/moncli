import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/utils/utils.dart';
import 'pub_subcommand/all_subcommand_export.dart';

class PubCommand extends CommandBase {
  PubCommand() {
    addSubcommand(InstallSubCommand());
    addSubcommand(AssetManagerSubCommand());
  }

  @override
  String get description =>
      'Manipulate the pubspec.yaml, according to the subcommand(options)';

  @override
  String get name => 'pub';

  @override
  String get invocation => 'moncli pub ${Logger.yellow('[subCommand]')}';
}
