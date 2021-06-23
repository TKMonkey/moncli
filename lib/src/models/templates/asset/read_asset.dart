import 'package:moncli/src/models/node/i_node_factory.dart';
import 'package:moncli/src/models/templates/asset/asset_template_runner.dart';
import 'package:moncli/src/models/templates/asset/yaml_asset_template.dart';

class ReadAssetsParams {
  final bool create;
  final INodeFactory nodeFactory;
  final String assetsOutputPath;

  ReadAssetsParams({
    required this.create,
    required this.nodeFactory,
    required this.assetsOutputPath,
  });
}

class ReadAssets {
  void call(ReadAssetsParams params) {
    final template = YamlAssetTemplate(params.assetsOutputPath);
    final templateRunner = AssetTemplateRunnner(params.nodeFactory);

    templateRunner(template, AssetTemplateRunnnerParams(create: params.create));
  }
}
