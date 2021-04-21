import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/models/yaml/yaml_model.dart';
import 'package:moncli/src/utils/utils.dart';

class RunScriptSubCommand extends CommandBase {
  @override
  final name = 'run';

  @override
  final description = 'Run scripts in pubspec.yaml';

  @override
  String get invocation => yellow('moncli run [script-name]');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    commandUtils
      ..existsPubspec()
      ..argsIsEmpty(argsIsEmpty, 'not script passed for a $name command.');

    final script = YamlModel.pubspec().getScriptFromPubspec(argResults!.rest.first);

    commandUtils.run(script);
  }
}
