import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:moncli/src/models/pub_package.dart';
import 'package:moncli/src/models/pubspec/pubspec.dart';
import 'package:moncli/src/utils/utils.dart';

Future<bool> install(ArgResults argResults) async {
  final bool isDev = argResults['dev'] as bool;
  final bool doSort = argResults['sort'] as bool;

  final packageList = (await Future.wait(argResults.rest
          .map((pack) async => getPackageFromPub(pack, isDev))
          .toList()))
      .splitMatch((pkg) => pkg.isValid);

  final yaml = Pubspec.init(isDev: isDev, doSort: doSort)
    ..addDependencies(packageList.matched)
    ..saveYaml();

  installReport(packageList);

  return yaml.containsFlutterKey;
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
    for (final pack in list.matched) {
      logger.info('✔ ${pack.name}: ${pack.version}');
    }
  }

  if (list.unmatched.isNotEmpty) {
    logger
      ..info('')
      ..err('> Package not found:');

    for (final pack in list.unmatched) {
      logger.info('x ${pack.name}');
    }
  }
}
