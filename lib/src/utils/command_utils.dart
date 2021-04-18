import 'package:dcli/dcli.dart' show PubSpec;
import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/utils/files/pubspec_file.dart';

import 'utils.dart';

abstract class CommandUtils {}

class PubCommandUtils implements CommandUtils {
  final pubspec = 'TEST'.isEmpty ? 'pubspec.yaml' : 'envtest/pubspec_test.yaml';

  late final PubSpec _pubspecFile;

  void addToDependencies(List<PackageModel> list, bool isDev) {
    _pubspecFile = PubSpec.fromFile(pubspec);
    addToDependenciesUtil(_pubspecFile, list, isDev);
  }

  void saveFile() {
    saveFileUtil(_pubspecFile);
  }

  bool existsPubspec() {
    if (!existsUtil(pubspec)) {
      throw const FormatException('No pubspec.yaml file in project.');
    }

    return true;
  }
}
