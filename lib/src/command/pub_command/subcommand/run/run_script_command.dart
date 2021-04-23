import 'package:args/args.dart';
import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/models/pubspec/pubspec.dart';
import 'package:moncli/src/utils/utils.dart';

class RunScriptSubCommand extends CommandBase {
  @override
  final name = 'run';

  @override
  final description = 'Run scripts in pubspec.yaml';

  @override
  String get invocation => yellow('moncli run [script-name]');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    commandUtils
      ..existsPubspec()
      ..argsIsEmpty(argsIsEmpty, 'not script passed for a $name command.')
      ..runAndExecute(runFunction(argResults!));
  }
}

Future<String> runFunction(ArgResults argResults) async {
  return Pubspec.init().getScriptFromPubspec(argResults.rest.first);
}
