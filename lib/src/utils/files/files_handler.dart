import 'package:dcli/dcli.dart' show exists, StringAsProcess;

bool existsUtil(String path) {
  return exists(path);
}

bool isUsedInProject(String name) {
  try {
    'grep -Ril "import \'package:$name" ./lib'.forEach((line) {});
    return true;
  } catch (e) {
    return false;
  }
}
