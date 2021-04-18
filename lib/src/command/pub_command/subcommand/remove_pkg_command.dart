import 'package:args/command_runner.dart';

import 'package:moncli/src/base/base_command.dart';
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
    logger.info('--Remove--');
    commandUtils.existsPubspec();

    if (argsIsEmpty) {
      throw UsageException('not package passed for a install command.', usage);
    } else {
      // argResults!.rest.forEach((element) {
      //   print(element);
      // });

      logger.info('INIT Remove');

      // return install(argResults.rest, argResults['dev']);
    }
  }
}
