import 'package:dcli/dcli.dart';
import 'package:injectable/injectable.dart';
import 'package:moncli/src/command/pub_command/subcommand/asset/i_files_repository';

abstract class IFileDataSource {
  bool existsPath(String path);

  void createFile(String path);

  void createDirectory(String path);

  void copyFile(String sourcePath, String destinationPath);
}

abstract class IUserPromptDataSource {
  bool getTrueOrFalse(String question);
}

@LazySingleton(as: IFilesRepository)
class FileRepository implements IFilesRepository {
  final IFileDataSource filesDataSource;
  final IUserPromptDataSource userPromptDataSource;

  FileRepository(this.filesDataSource, this.userPromptDataSource);

  @override
  bool existsPath(String path) => filesDataSource.existsPath(path);

  @override
  bool canCreatePath(String path, String boldStatement) => userPromptDataSource
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
      filesDataSource.copyFile(sourcePath, destinationPath);
}
