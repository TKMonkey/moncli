import 'package:injectable/injectable.dart';
import 'package:moncli/src/base/constants.dart';

import '../i_exists_path.dart';

abstract class IExistsTemplateDirectory {
  bool call();
}

@LazySingleton(as: IExistsTemplateDirectory)
class ExistsTemplateDirectory implements IExistsTemplateDirectory {
  final IExistsPath existsPath;
  final IPathConstants pathConstants;

  ExistsTemplateDirectory(this.existsPath, this.pathConstants);

  @override
  bool call() => existsPath(pathConstants.templateFolderPath);
}
