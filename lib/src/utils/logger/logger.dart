import 'dart:io';
import 'package:moncli/src/utils/logger/colors.dart';

/// A basic Logger which wraps [print] and applies various styles.
/// Copy from Mason library

Logger get logger => Logger._();

class Logger {
  Logger._();

  final _queue = <String>[];

  /// Flushes internal message queue.
  void flush([Function(String)? print]) {
    final writeln = print ?? info;
    for (final message in _queue) {
      writeln(message);
    }
    _queue.clear();
  }

  /// Writes info message to stdout.
  void info(String message) => stdout.writeln(message);

  /// Writes error message to stdout.
  void err(String message) => stdout.writeln(red(message));

  /// Writes alert message to stdout.
  void alert(String message) {
    stdout.writeln(cyan(message));
  }

  /// Writes warning message to stdout.
  void warn(String message) {
    stdout.writeln(yellow('[WARN] $message'));
  }

  /// Writes success message to stdout.
  void success(String message) => stdout.writeln(green(message));

  /// Writes delayed message to stdout.
  void delayed(String message) => _queue.add(message);
}
