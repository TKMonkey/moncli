import 'package:moncli/src/domain/files/create_path/i_create_template_directory.dart';
import 'package:moncli/src/domain/files/i_can_create_path/i_can_create_template_directory.dart';
import 'package:moncli/src/domain/files/i_exists/i_exists_template_directory.dart';

abstract class IHandleTemplateDirectoryCreation {
  void call();
}

class HandleTemplateDirectoryCreation
    implements IHandleTemplateDirectoryCreation {
  final IExistsTemplateDirectory existsTemplateDirectory;
  final ICreateTemplatesDirectory createTemplatesDirectory;
  final ICanCreateTemplatesDirectory canCreateTemplatesDirectory;

  HandleTemplateDirectoryCreation(this.existsTemplateDirectory,
      this.createTemplatesDirectory, this.canCreateTemplatesDirectory);

  @override
  void call() {
    if (existsTemplateDirectory()) {
      return;
    }
    if (canCreateTemplatesDirectory()) {
      createTemplatesDirectory();
    }
  }
}
