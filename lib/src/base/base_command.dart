import 'package:args/command_runner.dart';

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

  // @override
  // FutureOr<void> run() {
  //   formatFiles(LocalSaveLog().lastCreatedFiles(true));
  // }
}
