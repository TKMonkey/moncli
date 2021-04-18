import 'package:dcli/dcli.dart' show PubSpec;
import 'package:moncli/src/utils/files/pubspec_file.dart';

import 'utils.dart';

abstract class CommandUtils {}

class PubCommandUtils implements CommandUtils {
  late final PubSpec _pubspecFile;

  void loadPubspec() {
    _pubspecFile = PubSpec.fromFile('pubspec.yaml');
  }

  void addToDependencies(String name, String version) {
    addToDependenciesUtil(_pubspecFile, name, version);
  }

  void addToDevDependencies(String name, String version) {
    addToDevDependenciesUtil(_pubspecFile, name, version);
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
