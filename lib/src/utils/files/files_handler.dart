import 'package:dcli/dcli.dart' show exists, StringAsProcess, createDir, copy;

bool existsUtil(String path) {
  return exists(path);
}

void createFolderUtils(String path) {
  final ss = createDir(path, recursive: true);
  print('FOLDER: $ss');
}

void copyFileUtils(String from, String to) {
  copy(from, to, overwrite: true);
}

bool isUsedInProject(String name) {
  try {
    'grep -Ril "import \'package:$name" ./lib'.forEach((line) {});
    return true;
  } catch (e) {
    return false;
  }
}
