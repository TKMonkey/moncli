import 'dart:async';
import 'dart:io';
import 'package:dcli/dcli.dart' as dcli;

import 'package:args/command_runner.dart';
import 'package:moncli/src/base/base_command.dart';

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
  String get invocation => dcli.yellow('moncli install [packages]');

  @override
  FutureOr<void> run() async {
    if (!dcli.exists('pubspec.yaml')) {
      dcli.printerr('No pubspec.yaml file in project.');
      exit(1);
    }

    if (argResults?.rest.isEmpty == true) {
      throw UsageException('not package passed for a install command.', usage);
    } else {
      // argResults!.rest.forEach((element) {
      //   print(element);
      // });

      dcli.printerr('INIT INSTALL');

      // return install(argResults.rest, argResults['dev']);
    }
  }
}
