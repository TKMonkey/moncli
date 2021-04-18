import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/models/pubspec_model.dart';
import 'package:moncli/src/utils/files/pubspec_file.dart';

import 'utils.dart';

abstract class CommandUtils {}

class PubCommandUtils implements CommandUtils {
  bool existsPubspec() {
    if (!existsUtil(pubspecDirectory)) {
      throw const FormatException('No pubspec.yaml file in project.');
    }

    return true;
  }

  void readYaml() {}
}
