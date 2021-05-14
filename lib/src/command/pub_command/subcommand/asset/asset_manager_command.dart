import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/models/templates/asset/read_asset.dart';
import 'package:moncli/src/utils/utils.dart';

class AssetManagerSubCommand extends CommandBase {
  AssetManagerSubCommand() {
    argParser
      ..addFlag(
        'create',
        abbr: 'c',
        defaultsTo: true,
        help: 'Create the AssetManager class in Dart',
      )
      ..addFlag(
        'overwrite',
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
    final overwrite = argResults != null ? argResults!['overwrite'] : false;

    commandUtils.existsPubspec();

    final created = commandUtils.createAssetsTemplate(overwrite: overwrite);
    if (created) {
      ReadAssets.read()
        ..validateData()
        ..create(argResults);
    }
  }
}
