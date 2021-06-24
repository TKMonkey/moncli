import 'package:injectable/injectable.dart';
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_create_path.dart';

abstract class ICreateTemplatesDirectory {
  void call();
}

@LazySingleton(as: ICreateTemplatesDirectory)
class CreateTemplatesDirectory implements ICreateTemplatesDirectory {
  final IPathConstants pathConstants;
  final ICreatePath createPath;

  CreateTemplatesDirectory(this.pathConstants, this.createPath);

  @override
  void call() => createPath(pathConstants.templateFolderPath,
      overwrite: false, isFile: false);
}
