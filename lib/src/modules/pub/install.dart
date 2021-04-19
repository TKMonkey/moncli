import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/models/yaml_model.dart';
import 'package:moncli/src/utils/reports/report_utils.dart';
import 'package:moncli/src/utils/utils.dart';
import 'package:http/http.dart' as http;

Future<bool> install(ArgResults argResults) async {
  bool isDev = argResults['dev'];
  bool doSort = argResults['sort'];

  final packageList = (await Future.wait(argResults.rest
          .map((pack) async => await getPackageFromPub(pack, isDev))
          .toList()))
      .splitMatch((pkg) => pkg.isValid);

  final yaml = YamlModel.pubspec(isDev, doSort)
    ..addDependencies(packageList.matched)
    ..saveYaml();

  installReport(packageList);

  return yaml.isFlutter;
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
