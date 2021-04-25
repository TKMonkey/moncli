import 'package:dcli/dcli.dart'
    show exists, StringAsProcess, createDir, copy, find, delete, write;

bool existsUtil(String path) {
  return exists(path);
}

void createFolderUtils(String path) {
  if (!existsUtil(path)) {
    createDir(path, recursive: true);
  }
}

void deleteFileUtils(String path) {
  if (existsUtil(path)) {
    delete(path);
  }
}

void createFileUtils(String path) {
  if (!existsUtil(path)) {
    path.write('');
  }
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

List<String> getListOfFiles(String path) {
  return find('*.*', workingDirectory: path).toList();
}
