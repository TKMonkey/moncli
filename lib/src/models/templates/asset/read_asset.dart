import 'package:moncli/src/domain/files/i_exists/i_exists_assets_template.dart';
import 'package:moncli/src/domain/files/i_exists/i_existss_pub_spec.dart';
import 'package:moncli/src/domain/files/i_handle_assets_template_creation.dart';
import 'package:moncli/src/models/node/i_node_factory.dart';
import 'package:moncli/src/models/templates/asset/asset_template_runner.dart';
import 'package:moncli/src/models/templates/asset/yaml_asset_template.dart';

class ReadAssetsParams {
  final bool create;
  final bool overwrite;
  final INodeFactory nodeFactory;
  final String assetsOutputPath;

  ReadAssetsParams({
    required this.create,
    required this.overwrite,
    required this.nodeFactory,
    required this.assetsOutputPath,
  });
}

class ReadAssets {
  final IExistsPubspec existsPubspec;
  final IExistsAssetsTemplate existsAssetsTemplate;
  final IHandleAssetsTemplateCreation handleAssetsTemplateCreation;

  ReadAssets(this.existsPubspec, this.existsAssetsTemplate,
      this.handleAssetsTemplateCreation);

  void call(ReadAssetsParams params) {
    _validate();

    _setup(params);

    if (!existsAssetsTemplate()) {
      return;
    }

    _execute(params);
  }

  void _validate() {
    if (!existsPubspec()) {
      throw const FormatException('No pubspec.yaml file in project.');
    }
  }

  void _setup(ReadAssetsParams params) {
    if (existsAssetsTemplate()) {
      return;
    }

    handleAssetsTemplateCreation(overwrite: params.overwrite);
  }

  void _execute(ReadAssetsParams params) {
    final template = YamlAssetTemplate(params.assetsOutputPath);
    final templateRunner = AssetTemplateRunnner(params.nodeFactory);

    templateRunner(template, AssetTemplateRunnnerParams(create: params.create));
  }
}
