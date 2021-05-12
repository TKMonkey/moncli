import 'package:dcli/dcli.dart' show StringAsProcess;
import 'package:moncli/src/base/constants.dart';

import 'logger/prompt.dart';
import 'utils.dart';

abstract class CommandUtils {
  bool existsAndCreateTemplateFolder() {
    final exists = existsUtil(templateFolderPath);
    var response = true;
    if (!exists) {
      response = confirmDcli(
          'Do you want to create ${green('template folder')} ?',
          defaultValue: true);
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

  bool createAssetsTemplate({bool overwrite = false}) {
    final responseFolder = existsAndCreateTemplateFolder();

    var response = false;
    var exists = false;

    if (responseFolder) {
      exists = existsUtil(assetsOutputPath);
      if (!exists) {
        response = confirmDcli(
            'Do you want to create ${green('assets template file')} ?',
            defaultValue: true);
      } else if (overwrite) {
        logger.alert('The file will be overwritten');
      }
    }
    if (overwrite || response) {
      copyFileUtils(assetsTemplatePath, assetsOutputPath);
    }

    return exists || response;
  }

  void argsIsEmpty(bool empty, String commanError) {
    if (empty) {
      throw FormatException(commanError);
    }
  }

  Future<void> runAndExecute(Future<String> runFunction) async {
    final commandToRun = await runFunction;

    if (commandToRun.isNotEmpty) commandToRun.run;
  }

  Future<void> runAndUpdate(Future<bool> runFunction) async {
    final containsFlutter = await runFunction;
    updatePubspec(containsFlutter);
  }

  void updatePubspec(bool containsFlutter) {
    (containsFlutter ? 'flutter pub get' : 'pub get').run;
  }
}
