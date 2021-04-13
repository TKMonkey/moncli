import 'dart:io';
import 'package:io/ansi.dart' as color;

Printerr get printerr => const Printerr._();

class Printerr {
  const Printerr._();

  void red(String message) {
    printLn(color.lightRed.wrap(message));
  }

  String redStr(String message) {
    return color.lightRed.wrap(message) ?? '';
  }

  void green(String message) {
    printLn(color.lightGreen.wrap(message));
  }

  String greenStr(String message) {
    return color.lightRed.wrap(message) ?? '';
  }

  void white(String message) {
    printLn(color.white.wrap(message));
  }

  void w(String message) {
    white(message);
  }

  String whiteStr(String message) {
    return color.lightRed.wrap(message) ?? '';
  }

  void yellow(String message) {
    printLn(color.yellow.wrap(message));
  }

  String yellowStr(String message) {
    return color.lightRed.wrap(message) ?? '';
  }

  void blue(String message) {
    printLn(color.lightBlue.wrap(message));
  }

  String blueStr(String message) {
    return color.lightRed.wrap(message) ?? '';
  }

  void printLn(String? message) {
    stdout.writeln(message);
  }
}
