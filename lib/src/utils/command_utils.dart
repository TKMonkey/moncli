import 'package:dcli/dcli.dart' show PubSpec;
import 'package:moncli/src/models/package_model.dart';
import 'package:moncli/src/utils/files/pubspec_file.dart';

import 'utils.dart';

abstract class CommandUtils {}

class PubCommandUtils implements CommandUtils {
  late final PubSpec _pubspecFile;

  void addToDependencies(List<PackageModel> list, bool isDev) {
    _pubspecFile = PubSpec.fromFile('pubspec.yaml');
    addToDependenciesUtil(_pubspecFile, list, isDev);
  }

  void saveFile() {
    saveFileUtil(_pubspecFile);
  }

  bool existsPubspec() {
    if (!existsUtil('pubspec.yaml')) {
      throw const FormatException('No pubspec.yaml file in project.');
    }

    return true;
  }
}
