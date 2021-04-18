import 'package:dcli/dcli.dart' show PubSpec;
import 'package:pubspec/pubspec.dart' show HostedReference;

void addToDependenciesUtil(PubSpec pub, String name, String version) {
  final dependency = {
    name: HostedReference.fromJson(version),
  };

  pub.pubspec.dependencies.addAll(dependency);
}

void addToDevDependenciesUtil(PubSpec pub, String name, String version) {
  final dependency = {
    name: HostedReference.fromJson(version),
  };

  pub.pubspec.devDependencies.addAll(dependency);
}

void saveFileUtil(PubSpec pub) {
  pub.saveToFile('.');
}
