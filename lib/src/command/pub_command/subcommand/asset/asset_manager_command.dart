import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/templates/asset/read_asset.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/utils/utils.dart';

class AssetManagerSubCommand extends CommandBase {
  static const createFlag = 'create';
  static const overwriteFlag = 'overwrite';

  AssetManagerSubCommand() {
    argParser
      ..addFlag(
        createFlag,
        abbr: 'c',
        defaultsTo: true,
        help: 'Create the AssetManager class in Dart',
      )
      ..addFlag(
        overwriteFlag,
        abbr: 'o',
        negatable: false,
        help: 'Override current asset_manager_config with default template',
      );
  }

  @override
  final name = 'assets';

  @override
  final description =
      'Read and write all assets in pubspec and create the AssetManager class';

  @override
  String get invocation => yellow('moncli assets');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    final bool overwrite = argResults![overwriteFlag] as bool;

    commandUtils.existsPubspec();

    final created = commandUtils.createAssetsTemplate(overwrite: overwrite);
    final bool mustCreate = argResults![createFlag] as bool;

    if (created) {
      final readAssets = ReadAssets();
      readAssets(
        ReadAssetsParams(
            create: mustCreate,
            nodeFactory: YamlNodeFactory.sInstance,
            assetsOutputPath: assetsOutputPath),
      );
    }
  }
}
