import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/models/pubspec_model.dart';
import 'package:moncli/src/models/yaml_model.dart';
import 'package:moncli/src/utils/files/pubspec_file.dart';
import 'package:moncli/src/utils/files/yaml_util.dart';

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
}
