import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/utils/utils.dart';

class InstallCommand extends CommandBase {
  InstallCommand() {
    argParser.addFlag(
      'dev',
      abbr: 'd',
      negatable: false,
      help: 'Install (or update) a package in a dev dependency',
    );
  }

  @override
  final name = 'install';

  @override
  final description = 'Install (or update) a new package or packages';

  @override
  String get invocation => Logger.yellow('moncli install [packages]');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    logger.info('--Install--');
    commandUtils.existsPubspec();

    if (argsIsEmpty) {
      throw UsageException('not package passed for a install command.', usage);
    } else {
      // argResults!.rest.forEach((element) {
      //   print(element);
      // });

      logger.info('INIT INSTALL');

      // return install(argResults.rest, argResults['dev']);
    }
  }
}
