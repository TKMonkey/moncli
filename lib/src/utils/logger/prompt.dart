import 'dart:io';

mixin PromptMessage {
  // TODO Improve this prompt
  /// Prompts user and returns response.
  String prompt(String message) {
    stdout.write('$message');
    return stdin.readLineSync() ?? '';
  }
}
