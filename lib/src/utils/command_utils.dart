import 'package:moncli/src/models/yaml/yaml_model.dart';
import 'package:dcli/dcli.dart' as dcli;
import 'utils.dart';

abstract class CommandUtils {}

final environment = 'TEST';

final mainDirectory = environment.isEmpty ? '' : 'filetest';
final pubspecDirectory1 =
    environment.isEmpty ? 'pubspec.yaml' : '$mainDirectory/pubspec_test.yaml';

class PubCommandUtils implements CommandUtils {
  void existsPubspec() {
    if (!existsUtil(pubspecDirectory)) {
      throw const FormatException('No pubspec.yaml file in project.');
    }
  }

  void argsIsEmpty(bool empty, String commanError) {
    if (empty) {
      throw FormatException(commanError);
    }
  }

  void run(String commandToRun) async {
    if (commandToRun.isNotEmpty) commandToRun.run;
  }

  void runAndUpdate(Future<bool> runFunction) async {
    final containsFlutter = await runFunction;
    updatePubspec(containsFlutter);
  }

  void updatePubspec(bool containsFlutter) {
    (containsFlutter ? 'flutter pub get' : 'pub get').run;
  }
}
