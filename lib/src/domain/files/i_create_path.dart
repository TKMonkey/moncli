import 'package:injectable/injectable.dart';
import 'package:moncli/src/domain/files/i_exists_path.dart';
import 'package:moncli/src/domain/files/i_files_repository.dart';
import 'package:moncli/src/utils/logger/logger.dart';

abstract class ICreatePath {
  void call(String path, {required bool overwrite, required bool isFile});
}

@LazySingleton(as: ICreatePath)
class CreatePath implements ICreatePath {
  final IExistsPath existsPath;
  final IFilesRepository filesRepository;

  CreatePath(this.existsPath, this.filesRepository);

  @override
  void call(String path, {required bool overwrite, required bool isFile}) {
    if (overwrite) {
      _handleWithOverwrite(path, isFile);
      return;
    }

    _handleWithoutOverwrite(path, isFile);
  }

  void _handleWithOverwrite(String path, bool isFile) {
    final exists = existsPath(path);

    if (exists) {
      logger.alert("The path $path will be overwritten");
    }

    _createPath(path, isFile);
  }

  void _handleWithoutOverwrite(String path, bool isFile) {
    final exists = existsPath(path);

    if (exists) {
      return;
    }

    _createPath(path, isFile);
  }

  void _createPath(String path, bool isFile) {
    if (isFile) {
      return filesRepository.createFile(path, overwrite: true);
    } else {
      return filesRepository.createDirectory(path);
    }
  }
}
