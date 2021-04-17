import 'package:args/command_runner.dart';
import 'package:moncli/src/utils/utils.dart';

abstract class CommandBase extends Command {
  String? invocationSuffix;

  @override
  String get invocation {
    return invocationSuffix != null && invocationSuffix?.isNotEmpty == true
        ? '${super.invocation} $invocationSuffix'
        : '${super.invocation}';
  }

  @override
  String get description;

  @override
  String get name;

  bool get argsIsEmpty => argResults?.rest.isEmpty == true;

  late CommandUtils commandUtils;

  // @override
  // FutureOr<void> run() {
  //   formatFiles(LocalSaveLog().lastCreatedFiles(true));
  // }
}
