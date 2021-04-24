import 'package:moncli/lib.dart';

// ignore: avoid_void_async
void main(List<String> arguments) async {
  await Moncli().runCommand(arguments);
  // testDCLI(arguments);
}

// void testDCLI(List<String> arguments) async {
// print(dcli.HOME);

// print(dcli.PubCache().cacheDir);

//dcli.createDir('${dcli.HOME}/monclitemples', );
// }
