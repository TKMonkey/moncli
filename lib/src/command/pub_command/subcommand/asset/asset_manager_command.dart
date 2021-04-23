import 'package:dcli/dcli.dart' as dcli;
import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/models/templates/assets_manager.dart';
import 'package:moncli/src/utils/utils.dart';

class AssetManagerSubCommand extends CommandBase {
  AssetManagerSubCommand() {
    argParser
      ..addFlag(
        'nocreate',
        abbr: 'n',
        negatable: false,
        help: 'No create the AssetManager class in Dart',
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
    bool overwrite = argResults!['overwrite'];
    commandUtils.existsPubspec();
    final created = commandUtils.createAssetsTemplate(overwrite: overwrite);
    if (created) {
      print('-Created-');

      AssetManager.read()
        ..validateData()
        ..create();
    }
  }
}