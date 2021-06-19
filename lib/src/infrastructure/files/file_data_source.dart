import 'package:dcli/dcli.dart';
import 'package:moncli/src/base/constants.dart';

import 'files_repository.dart';

class FileDataSource implements IFileDataSource {
  final IPathConstants pathConstants;

  FileDataSource(this.pathConstants);

  @override
  bool existsPath(String path) {
    return exists(path);
  }

  @override
  void createFile(String path) {
    path.write('');
  }

  @override
  void createDirectory(String path) {
    createDir(path, recursive: true);
  }
}
