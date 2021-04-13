import 'dart:io';

import 'package:moncli/lib.dart';
import 'package:dcli/dcli.dart' as dcli;

void main(List<String> arguments) async {
  Moncli().runCommand(arguments);
  // testDCLI(arguments);
}

void testDCLI(List<String> arguments) async {
  // print(dcli.HOME);

  // print(dcli.PubCache().cacheDir);

  //dcli.createDir('${dcli.HOME}/monclitemples', );
}
