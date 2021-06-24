import 'package:injectable/injectable.dart';
import 'package:moncli/src/base/constants.dart';

import '../i_exists_path.dart';

abstract class IExistsAssetsTemplate {
  bool call();
}

@LazySingleton(as: IExistsAssetsTemplate)
class ExistsAssetsTemplate implements IExistsAssetsTemplate {
  final IExistsPath existsPath;
  final IPathConstants pathConstants;

  ExistsAssetsTemplate(this.existsPath, this.pathConstants);

  @override
  bool call() => existsPath(pathConstants.assetsOutputPath);
}
