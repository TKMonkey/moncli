import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/utils/utils.dart';

class RunScriptSubCommand extends CommandBase {
  @override
  final name = 'run';

  @override
  final description = 'Run scripts in pubspec.yaml';

  @override
  String get invocation => Logger.yellow('moncli run [script-name]');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    logger.info('--Assets--');
    commandUtils.existsPubspec();

    logger.info('INIT ASSSETS');
  }
}
