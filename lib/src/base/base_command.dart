import 'package:args/command_runner.dart';
import 'package:moncli/src/logger/logger.dart';
import 'package:moncli/src/logger/printerr.dart';

abstract class CommandBase extends Command {
  String? invocationSuffix;

  Printerr get printerr => const Printerr();

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
