import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class InstallSubCommand extends CommandBase {
  InstallSubCommand() {
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
  String get invocation => yellow('moncli install [packages]');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    logger.info('----- Init install package -----');
    commandUtils.existsPubspec();

    if (argsIsEmpty) {
      throw UsageException('not package passed for a remove command.', usage);
    } else {
      bool isDev = argResults!['dev'];
      final packageList = (await Future.wait(argResults!.rest
              .map((pack) async => await getPackageFromPub(pack, isDev))
              .toList()))
          .splitMatch((pkg) => pkg.isValid);

      commandUtils
        ..addToDependencies(packageList.matched, isDev)
        ..saveFile();
    }
  }

  Future<PackageModel> getPackageFromPub(String pkgName, bool isDev) async {
    final url = Uri.parse('https://pub.dev/api/packages/$pkgName');

    final response = await http.get(url);
    final data = json.decode(response.body);

    if (response.statusCode == HttpStatus.notFound) {
      return PackageModel(
        pkgName,
        isDev: isDev,
        isValid: false,
      );
    }

    return PackageModel(
      pkgName,
      isDev: isDev,
      version: '^${data['latest']['version']}',
    );
  }
}
