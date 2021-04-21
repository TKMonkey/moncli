import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/utils/utils.dart';

class UnusedPkgSubCommand extends CommandBase {
  UnusedPkgSubCommand() {
    argParser.addFlag(
      'remove',
      abbr: 'r',
      negatable: false,
      help: 'Remove the unused package',
    );
  }

  @override
  final name = 'unused';

  @override
  final description = 'See the unused package in pubspec.yaml';

  @override
  String get invocation => yellow('moncli unused');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    logger.info('--Unused--');
    commandUtils.existsPubspec();

    logger.info('INIT unused');
  }
}
