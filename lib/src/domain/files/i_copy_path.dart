import 'package:moncli/src/command/pub_command/subcommand/asset/i_files_repository';
import 'package:moncli/src/domain/files/i_exists_path.dart';
import 'package:moncli/src/utils/logger/logger.dart';

abstract class ICopyFile {
  void call(String sourcePath, String destinationPath,
      {required bool overwrite});
}

class CopyPath implements ICopyFile {
  final IExistsPath existsPath;
  final IFilesRepository filesRepository;

  CopyPath(this.existsPath, this.filesRepository);

  @override
  void call(String sourcePath, String destinationPath,
      {required bool overwrite}) {
    if (overwrite) {
      return _handleWithOverwrite(sourcePath, destinationPath);
    }
    return _handleWithoutOverwrite(sourcePath, destinationPath);
  }

  void _handleWithOverwrite(String sourcePath, String destinationPath) {
    final exists = existsPath(destinationPath);

    if (exists) {
      logger.alert("The file $destinationPath will be overwritten");
    }

    filesRepository.copyFile(sourcePath, destinationPath);
  }

  void _handleWithoutOverwrite(String sourcePath, String destinationPath) {
    final exists = existsPath(destinationPath);

    if (exists) {
      return;
    }

    filesRepository.copyFile(sourcePath, destinationPath);
  }
}
