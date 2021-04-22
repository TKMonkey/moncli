import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/pubspec/pubspec_model.dart';
import 'package:moncli/src/utils/utils.dart';
import 'package:http/http.dart' as http;

Future<bool> install(ArgResults argResults) async {
  bool isDev = argResults['dev'];
  bool doSort = argResults['sort'];

  final packageList = (await Future.wait(argResults.rest
          .map((pack) async => await getPackageFromPub(pack, isDev))
          .toList()))
      .splitMatch((pkg) => pkg.isValid);

  final yaml = Pubspec.init(isDev: isDev, doSort: doSort)
    ..addDependencies(packageList.matched)
    ..saveYaml();

  installReport(packageList);

  return yaml.containsFlutter;
}

Future<PubPackageModel> getPackageFromPub(String pkgName, bool isDev) async {
  final url = Uri.parse('https://pub.dev/api/packages/$pkgName');

  final response = await http.get(url);
  final data = json.decode(response.body);

  if (response.statusCode == HttpStatus.notFound) {
    return PubPackageModel(
      pkgName,
      isDev: isDev,
      isValid: false,
    );
  }

  return PubPackageModel(
    pkgName,
    isDev: isDev,
    version: '^${data['latest']['version']}',
  );
}

void installReport(ListMatch<PubPackageModel> list) {
  if (list.matched.isNotEmpty) {
    logger.success('> The next packages were added in pubspec.yaml:');
    for (var pack in list.matched) {
      logger.info('✔ ${pack.name}: ${pack.version}');
    }
  }

  if (list.unmatched.isNotEmpty) {
    logger
      ..info('')
      ..err('> Package not found:');

    for (var pack in list.unmatched) {
      logger.info('x ${pack.name}');
    }
  }
}
