import 'package:moncli/src/domain/files/copy_path/i_copy_assets_template.dart';
import 'package:moncli/src/domain/files/i_can_create_path/i_can_create_assets_template.dart';
import 'package:moncli/src/domain/files/i_exists/i_exists_template_directory.dart';
import 'package:moncli/src/domain/files/i_handle_template_directory_creation.dart';

abstract class IHandleAssetsTemplateCreation {
  void call({required bool overwrite});
}

class HandleAssetsTemplateCreation implements IHandleAssetsTemplateCreation {
  final ICopyAssetsTemplate copyAssetsTemplate;
  final ICanCreateAssetsTemplate canCreateAssetsTemplate;
  final IExistsTemplateDirectory existsTemplateDirectory;
  final IHandleTemplateDirectoryCreation handleTemplateDirectoryCreation;

  HandleAssetsTemplateCreation(
      this.copyAssetsTemplate,
      this.canCreateAssetsTemplate,
      this.existsTemplateDirectory,
      this.handleTemplateDirectoryCreation);

  @override
  void call({required bool overwrite}) {
    if (!canCreateAssetsTemplate()) {
      return;
    }

    handleTemplateDirectoryCreation();

    if (!existsTemplateDirectory()) {
      return;
    }

    copyAssetsTemplate(overwrite: overwrite);
  }
}
