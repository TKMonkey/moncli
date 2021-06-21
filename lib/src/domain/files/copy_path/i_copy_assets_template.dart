import 'package:injectable/injectable.dart';
import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_copy_path.dart';

abstract class ICopyAssetsTemplate {
  void call({bool overwrite = false});
}

@LazySingleton(as: ICopyAssetsTemplate)
class CopyAssetsTemplate implements ICopyAssetsTemplate {
  final IPathConstants pathConstants;
  final ICopyFile copyFile;

  CopyAssetsTemplate(this.pathConstants, this.copyFile);

  @override
  void call({bool overwrite = false}) =>
      copyFile(pathConstants.assetsTemplatePath, pathConstants.assetsOutputPath,
          overwrite: overwrite);
}
