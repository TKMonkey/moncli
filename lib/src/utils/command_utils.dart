import 'package:moncli/src/models/yaml_model.dart';
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

  void argsIsEmpty(bool empty, String commanName) {
    if (empty) {
      throw FormatException('not package passed for a $commanName command.');
    }
  }

  void run(Future runFunction) async {
    final isFlutter = await runFunction;
    updatePubspec(isFlutter);
  }

  void updatePubspec(bool isFlutter) {
    (isFlutter ? 'flutter pub get' : 'pub get').run;
  }
}
