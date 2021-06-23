import 'package:moncli/src/models/pubspec/pubspec.dart';
import 'package:moncli/src/models/templates/asset/asset_file.dart';
import 'package:moncli/src/models/templates/asset/asset_manager.dart';
import 'package:moncli/src/models/templates/i_template_runner.dart';
import 'package:moncli/src/utils/utils.dart';

import 'asset_template.dart';

class AssetTemplateRunnnerParams {
  final bool create;

  AssetTemplateRunnnerParams({required this.create});
}

class AssetTemplateRunnner
    implements ITemplateRunner<AssetTemplate, AssetTemplateRunnnerParams> {
  @override
  void call(AssetTemplate template, AssetTemplateRunnnerParams params) {
    final listFiles = _readAllAssets(template);

    final pub = Pubspec.init();
    final assetsFluterNode = pub.getNodeOrDefault<Map>('flutter', {});
    assetsFluterNode['assets'] =
        _getElementsToPub(template.folderStrategy, listFiles);
    pub
      ..assignNewValueNode('flutter', assetsFluterNode)
      ..saveYaml();

    if (params.create) {
      AssetManager(
        name: template.nameAssetsClass,
        outputName: template.nameAssetsFile,
        outputPath: template.folderOutput,
        data: listFiles,
      ).write();
    }
  }

  Iterable<AssetsFile> _readAllAssets(AssetTemplate template) {
    return getListOfFiles(template.assetsFolder)
        .map((element) => AssetsFile.init(
            template.assetsFolder, element, template.preFix, template.postFix))
        .where((af) =>
            !template.excludeSubFolder
                .any((element) => af.path.contains(element)) &&
            !template.excludeExtensionType
                .any((element) => af.outputPath.contains('.$element')));
  }

  Iterable<String> _getElementsToPub(
      bool isFolder, Iterable<AssetsFile> allElements) {
    return isFolder
        ? _getFolderStrategy(allElements)
        : _getSingleStrategy(allElements);
  }

  Iterable<String> _getFolderStrategy(Iterable<AssetsFile> allElements) =>
      allElements.map((e) => e.path).toSet();

  Iterable<String> _getSingleStrategy(Iterable<AssetsFile> allElements) =>
      allElements.map((e) => e.outputPath);
}
