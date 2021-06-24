import 'package:moncli/lib.dart';
import 'package:moncli/src/base/di.dart';

// ignore: avoid_void_async
void main(List<String> arguments) async {
  configureDependencies();

  await getIt.get<Moncli>().runCommand(arguments);
  // await Moncli(getIt.get<PubCommand>()).runCommand(arguments);
  // testDCLI(arguments);
}

// void testDCLI(List<String> arguments) async {
// print(dcli.HOME);

// print(dcli.PubCache().cacheDir);

//dcli.createDir('${dcli.HOME}/monclitemples', );
// }
