import 'dart:io';

import 'package:ansicolor/ansicolor.dart';

/// A basic Logger which wraps [print] and applies various styles.
/// Copy from Mason library

Logger get logger => const Logger._();

class Logger {
  const Logger._();

  final _queue = const <String>[];

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

  static final red = AnsiPen()..red();
  static final green = AnsiPen()..green();
  static final white = AnsiPen()..white();
  static final cyan = AnsiPen()..cyan(bold: true);
  static final yellow = AnsiPen()..yellow(bold: true);
}
