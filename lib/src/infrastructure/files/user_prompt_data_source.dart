import 'package:injectable/injectable.dart';
import 'package:moncli/src/infrastructure/files/files_repository.dart';
import 'package:moncli/src/utils/logger/prompt.dart';

@LazySingleton(as: IUserPromptDataSource)
class UserPromptDataSource implements IUserPromptDataSource {
  @override
  bool getTrueOrFalse(String question) {
    return confirmDcli(question);
  }
}
