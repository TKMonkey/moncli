import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/command/pub_command/subcommand/remove/remove.dart';
import 'package:moncli/src/utils/utils.dart';

class RemoveSubCommand extends CommandBase {
  RemoveSubCommand() {
    argParser.addFlag(
      'dev',
      abbr: 'd',
      negatable: false,
      help: 'Remove a package in a dev dependency',
    );
  }

  @override
  final name = 'remove';

  @override
  final description = 'Remove a package or packages';

  @override
  String get invocation => yellow('moncli remove [packages]');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    commandUtils
      ..existsPubspec()
      ..argsIsEmpty(argsIsEmpty, 'not package passed for a $name command.')
      ..runAndUpdate(remove(argResults!));
  }
}
