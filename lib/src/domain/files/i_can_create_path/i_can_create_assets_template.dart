import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/domain/files/i_can_create_path.dart';

abstract class ICanCreateAssetsTemplate {
  bool call();
}

class CanCreateAssetsTemplate implements ICanCreateAssetsTemplate {
  final ICanCreatePath canCreatePath;
  final IPathConstants pathConstants;

  CanCreateAssetsTemplate(this.canCreatePath, this.pathConstants);

  @override
  bool call() =>
      canCreatePath(pathConstants.assetsOutputPath, "assets template file");
}
