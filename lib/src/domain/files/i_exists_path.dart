import 'package:moncli/src/command/pub_command/subcommand/asset/i_files_repository';

abstract class IExistsPath {
  bool call(String path);
}

class ExistsPath implements IExistsPath {
  final IFilesRepository filesRepository;

  ExistsPath(this.filesRepository);

  @override
  bool call(String path) => filesRepository.existsPath(path);
}
