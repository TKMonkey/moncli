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
  final description = 'Install (or update) a new package or packages:';

  @override
  String get invocation => printerr.yellowStr('moncli install [packages]');

  @override
  Future<void> run() async {
    if (!existsFile('pubspec.yaml')) {
      printerr.red('No pubspec.yaml file in project.');
      //generateDone('Done');
      // exit(1);
    }

    if (argResults?.rest.isEmpty == true) {
      throw UsageException('not package passed for a install command.', usage);
    } else {
      // argResults!.rest.forEach((element) {
      //   print(element);
      // });

      printerr.w('INIT INSTALL');

      // return install(argResults.rest, argResults['dev']);
    }
  }
}
