import 'package:injectable/injectable.dart';
import 'package:moncli/src/domain/files/i_files_repository.dart';

abstract class ICanCreatePath {
  bool call(String path, String boldStatement);
}

@LazySingleton(as: ICanCreatePath)
class CanCreatePath implements ICanCreatePath {
  final IFilesRepository filesRepository;

  CanCreatePath(this.filesRepository);

  @override
  bool call(String path, String boldStatement) =>
      filesRepository.canCreatePath(path, boldStatement);
}
