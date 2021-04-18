import 'package:dcli/dcli.dart' show PubSpec;
import 'package:moncli/src/models/package_model.dart';
import 'package:pubspec/pubspec.dart' show HostedReference;

void addToDependenciesUtil(PubSpec pub, List<PackageModel> list, bool isDev) {
  final packages = {
    for (var pkg in list) pkg.name: HostedReference.fromJson(pkg.version)
  };

  if (isDev) {
    pub.pubspec.devDependencies.addAll(packages);
  } else {
    pub.pubspec.dependencies.addAll(packages);
  }
}

void saveFileUtil(PubSpec pub) {
  pub.saveToFile('.');
}
