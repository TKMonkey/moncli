import 'package:moncli/src/base/constants.dart';
import 'package:dcli/dcli.dart' show StringAsProcess;
import 'logger/prompt.dart';
import 'utils.dart';

abstract class CommandUtils {
  bool existsAndCreateTemplateFolder() {
    final exists = existsUtil(templateFolder);
    var response = true;
    if (!exists) {
      response = confirmDcli('Do you want to create ${green('template folder')} ?');
      print('Response: $response');
      if (response) createFolderUtils(templateFolder);
    }

    return response;
  }
}

class PubCommandUtils extends CommandUtils {
  void existsPubspec() {
    if (!existsUtil(pubspecFile)) {
      throw const FormatException('No pubspec.yaml file in project.');
    }
  }

  bool createAssetsTemplate() {
    final outputFile = '$templateFolder/$assetsTemplateName';
    final responseFolder = existsAndCreateTemplateFolder();

    var response = false;
    if (responseFolder) {
      final exists = existsUtil(outputFile);
      if (!exists) {
        response =
            confirmDcli('Do you want to create ${green('assets template file')} ?');
      } else {
        response =
            confirmDcli('Do you want to ${yellow('override assets template file')} ?');
      }
    }

    if (response) copyFileUtils(assetsPath, outputFile);
    return response;
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
