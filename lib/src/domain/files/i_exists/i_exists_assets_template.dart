import 'package:moncli/src/base/constants.dart';

import '../i_exists_path.dart';

abstract class IExistsAssetsTemplate {
  bool call();
}

class ExistsAssetsTemplate implements IExistsAssetsTemplate {
  final IExistsPath existsPath;
  final IPathConstants pathConstants;

  ExistsAssetsTemplate(this.existsPath, this.pathConstants);

  @override
  bool call() => existsPath(pathConstants.assetsOutputPath);
}
