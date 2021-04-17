import 'utils.dart';

abstract class CommandUtils {}

class PubCommandUtils implements CommandUtils {
  bool existsPubspec() {
    if (!existsFile('pubspec.yaml')) {
      throw const FormatException('No pubspec.yaml file in project.');
    }

    return true;
  }
}
