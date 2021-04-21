import 'dart:async';

import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/command/pub_command/subcommand/install/install.dart';
import 'package:moncli/src/utils/utils.dart';

class InstallSubCommand extends CommandBase {
  InstallSubCommand() {
    argParser
      ..addFlag(
        'dev',
        abbr: 'd',
        negatable: false,
        help: 'Install (or update) a package in a dev dependency',
      )
      ..addFlag(
        'sort',
        abbr: 's',
        negatable: false,
        help: 'Sort packages was installed in pubspec.yaml',
      );
  }

  @override
  final name = 'install';

  @override
  final description = 'Install (or update) a new package or packages';

  @override
  String get invocation => yellow('moncli install [packages]');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    commandUtils
      ..existsPubspec()
      ..argsIsEmpty(argsIsEmpty, name)
      ..runAndUpdate(install(argResults!));
  }
}
