import 'package:injectable/injectable.dart';
import 'package:moncli/src/command/pub_command/subcommand/asset/i_files_repository';

abstract class ICanCreatePath {
  bool call(String path, String boldStatement);
}

@LazySingleton(as: ICanCreatePath)
class CanCreatePath implements ICanCreatePath {
  final IFilesRepository filesRepository;

  CanCreatePath(this.filesRepository);

  @override
  bool call(String path, String boldStatement) {
    return filesRepository.canCreatePath(path, boldStatement);
  }
}
