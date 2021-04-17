import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/utils/utils.dart';

class AssetManagerSubCommand extends CommandBase {
  AssetManagerSubCommand() {
    argParser.addFlag(
      'nocreate',
      abbr: 'n',
      negatable: false,
      help: 'No create the AssetManager class in Dart',
    );
  }

  @override
  final name = 'assets';

  @override
  final description =
      'Read and write all assets in pubspec and create the AssetManager class';

  @override
  String get invocation => Logger.yellow('moncli assets');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    logger.info('--Assets--');
    commandUtils.existsPubspec();

    logger.info('INIT ASSSETS');
  }
}
