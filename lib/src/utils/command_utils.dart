import 'package:moncli/src/models/yaml_model.dart';

import 'utils.dart';

abstract class CommandUtils {}

final environment = 'TEST';

final mainDirectory = environment.isEmpty ? '' : 'filetest';
final pubspecDirectory1 =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';

class PubCommandUtils implements CommandUtils {
  bool existsPubspec() {
    if (!existsUtil(pubspecDirectory)) {
      throw const FormatException('No pubspec.yaml file in project.');
    }

    return true;
  }

  bool argsIsEmpty(bool empty, String commanName) {
    if (empty) {
      throw FormatException('not package passed for a $commanName command.');
    }

    return true;
  }

  void run(Future runFunction) async {
    await runFunction;
  }
}
