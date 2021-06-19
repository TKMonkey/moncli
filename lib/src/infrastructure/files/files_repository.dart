import 'package:dcli/dcli.dart';
import 'package:moncli/src/command/pub_command/subcommand/asset/i_files_repository';
import 'package:moncli/src/utils/command_utils.dart';

abstract class IFileDataSource {
  bool existsPath(String path);

  void createFile(String path);

  void createDirectory(String path);
}

abstract class IUserPromptDataSource {
  bool getTrueOrFalse(String question);
}

class FileRepository implements IFilesRepository {
  final PubCommandUtils commandUtils;
  final IFileDataSource filesDataSource;
  final IUserPromptDataSource userPromtDataSource;

  FileRepository(
      this.commandUtils, this.filesDataSource, this.userPromtDataSource);

  @override
  bool existsPath(String path) => filesDataSource.existsPath(path);

  @override
  bool canCreatePath(String path, String boldStatement) => userPromtDataSource
      .getTrueOrFalse("Do you want to create ${green(boldStatement)}?");

  @override
  void createDirectory(String path) => filesDataSource.createDirectory(path);

  @override
  void createFile(String path, {required bool overwrite}) {
    if (existsPath(path) && !overwrite) {
      return;
    }

    filesDataSource.createFile(path);
  }

  @override
  void copyFile(String sourcePath, String destinationPath) =>
      copy(sourcePath, destinationPath);
}
