abstract class IFilesRepository {
  bool existsPath(String path);

  bool canCreatePath(String path, String boldStatement);

  void createDirectory(String path);

  void createFile(String path, {required bool overwrite});

  void copyFile(String sourcePath, String destinationPath);
}
