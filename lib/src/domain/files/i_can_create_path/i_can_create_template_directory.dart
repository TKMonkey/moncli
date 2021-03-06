import 'package:injectable/injectable.dart';
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_can_create_path.dart';

abstract class ICanCreateTemplatesDirectory {
  bool call();
}

@LazySingleton(as: ICanCreateTemplatesDirectory)
class CanCreateTemplatesDirectory implements ICanCreateTemplatesDirectory {
  final ICanCreatePath canCreatePath;
  final IPathConstants pathConstants;

  CanCreateTemplatesDirectory(this.canCreatePath, this.pathConstants);

  @override
  bool call() =>
      canCreatePath(pathConstants.templateFolderPath, "templates directory");
}
