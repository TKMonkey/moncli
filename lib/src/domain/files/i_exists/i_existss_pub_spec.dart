import 'package:injectable/injectable.dart';
import 'package:moncli/src/base/constants.dart';

import '../i_exists_path.dart';

abstract class IExistsPubspec {
  bool call();
}

@LazySingleton(as: IExistsPubspec)
class ExistsPubspec implements IExistsPubspec {
  final IExistsPath existsPath;
  final IPathConstants pathConstants;

  ExistsPubspec(this.existsPath, this.pathConstants);

  @override
  bool call() => existsPath(pathConstants.pubspecFileName);
}
