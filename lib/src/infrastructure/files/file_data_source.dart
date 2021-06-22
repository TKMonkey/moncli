import 'package:dcli/dcli.dart';
import 'package:injectable/injectable.dart';
import 'package:moncli/src/base/constants.dart';

import 'files_repository.dart';

@LazySingleton(as: IFileDataSource)
class FileDataSource implements IFileDataSource {
  final IPathConstants pathConstants;

  FileDataSource(this.pathConstants);

  @override
  bool existsPath(String path) => exists(path);

  @override
  void createFile(String path) => path.write('');

  @override
  void createDirectory(String path) => createDir(path, recursive: true);

  @override
  void copyFile(String sourcePath, String destinationPath) =>
      copy(sourcePath, destinationPath);
}
