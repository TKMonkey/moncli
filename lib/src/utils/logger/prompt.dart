import 'package:dcli/dcli.dart' show confirm;

bool confirmDcli(String message, {bool? defaultValue}) {
  return confirm(message, defaultValue: defaultValue);
}

// mixin PromptMessage {
//   // TODO Improve this prompt
//   /// Prompts user and returns response.
//   String prompt(String message) {
//     stdout.write('$message');
//     return stdin.readLineSync() ?? '';
//   }
// }
