import 'package:dcli/dcli.dart' as dcli;

bool existsFile(String path) {
  return dcli.exists(path);
}
