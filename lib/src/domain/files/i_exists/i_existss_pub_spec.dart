import 'package:moncli/src/base/constants.dart';

import '../i_exists_path.dart';

abstract class IExistsPubspec {
  bool call();
}

class ExistsPubspec implements IExistsPubspec {
  final IExistsPath existsPath;
  final IPathConstants pathConstants;

  ExistsPubspec(this.existsPath, this.pathConstants);

  @override
  bool call() => existsPath(pathConstants.pubspecFileName);
}
