import 'package:moncli/src/base/constants.dart';
import 'package:dcli/dcli.dart' show StringAsProcess;
import 'logger/prompt.dart';
import 'utils.dart';

abstract class CommandUtils {
  bool existsAndCreateTemplateFolder() {
    final exists = existsUtil(templateFolderPath);
    var response = true;
    if (!exists) {
      response = confirmDcli('Do you want to create ${green('template folder')} ?');
      print('Response: $response');
      if (response) createFolderUtils(templateFolderPath);
    }

    return response;
  }
}

class PubCommandUtils extends CommandUtils {
  void existsPubspec() {
    if (!existsUtil(pubspecFileName)) {
      throw const FormatException('No pubspec.yaml file in project.');
    }
  }

  bool createAssetsTemplate({bool override = true}) {
    final responseFolder = existsAndCreateTemplateFolder();

    var response = false;

    if (responseFolder) {
      final exists = existsUtil(assetsOutputPath);
      if (!exists) {
        response =
            confirmDcli('Do you want to create ${green('assets template file')} ?');
      } else if (override) {
        logger.alert('The file will be overwritten');
      }
    }

    if (override || response) copyFileUtils(assetsTemplatePath, assetsOutputPath);
    return override || response;
  }

  void argsIsEmpty(bool empty, String commanError) {
    if (empty) {
      throw FormatException(commanError);
    }
  }

  void runAndExecute(Future<String> runFunction) async {
    final commandToRun = await runFunction;

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
