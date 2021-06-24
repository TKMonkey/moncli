import 'package:injectable/injectable.dart';
import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/templates/asset/read_asset.dart';
import 'package:moncli/src/models/yaml/node/yaml_node_factory.dart';
import 'package:moncli/src/utils/utils.dart';

abstract class IAssetsManagerSubCommand extends CommandBase {}

@LazySingleton(as: IAssetsManagerSubCommand)
class AssetManagerSubCommand extends IAssetsManagerSubCommand {
  static const createFlag = 'create';
  static const overwriteFlag = 'overwrite';

  final ReadAssets readAssets;

  AssetManagerSubCommand({required this.readAssets}) {
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
    final bool mustCreate = argResults![createFlag] as bool;

    final params = ReadAssetsParams(
        create: mustCreate,
        overwrite: overwrite,
        nodeFactory: YamlNodeFactory.sInstance,
        assetsOutputPath: assetsOutputPath);

    readAssets(params);
  }
}
