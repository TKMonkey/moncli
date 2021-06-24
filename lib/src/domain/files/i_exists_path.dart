import 'package:injectable/injectable.dart';
import 'package:moncli/src/domain/files/i_files_repository.dart';

abstract class IExistsPath {
  bool call(String path);
}

@LazySingleton(as: IExistsPath)
class ExistsPath implements IExistsPath {
  final IFilesRepository filesRepository;

  ExistsPath(this.filesRepository);

  @override
  bool call(String path) => filesRepository.existsPath(path);
}
