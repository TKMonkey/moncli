import 'package:args/args.dart';
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/node/i_node_factory.dart';
import 'package:moncli/src/models/templates/asset/asset_template.dart';
import 'package:moncli/src/models/templates/asset/asset_template_runner.dart';
import 'package:moncli/src/models/templates/asset/yaml_asset_template.dart';

class ReadAssets {
  final AssetTemplate _template;
  final AssetTemplateRunnner _templateRunner;

  ReadAssets(
      {required ArgResults argResults, required INodeFactory iNodeFactory})
      : _template = YamlAssetTemplate(assetsOutputPath),
        _templateRunner = AssetTemplateRunnner(iNodeFactory) {
    _templateRunner(
        _template, AssetTemplateRunnnerParams(create: argResults['create']));
  }
}
