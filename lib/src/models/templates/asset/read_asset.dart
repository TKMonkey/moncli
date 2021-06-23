import 'package:args/args.dart';
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/templates/asset/asset_template.dart';
import 'package:moncli/src/models/templates/asset/asset_template_runner.dart';
import 'package:moncli/src/models/templates/asset/asset_template_yaml.dart';

class ReadAssets {
  final AssetTemplate _template;
  final AssetTemplateRunnner _templateRunner;

  ReadAssets({required ArgResults argResults})
      : _template = AssetTemplateYaml(assetsOutputPath),
        _templateRunner = AssetTemplateRunnner() {
    _templateRunner(
        _template, AssetTemplateRunnnerParams(create: argResults['create']));
  }
}
