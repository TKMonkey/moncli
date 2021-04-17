import 'dart:async';
import 'dart:io';

import 'logger.dart';

/// Writes progress message to stdout.
mixin ProgressMessage {
  static const List<String> _progressAnimation = [
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏'
  ];

  final _stopwatch = Stopwatch();
  Timer? _timer;
  int _index = 0;

  void Function([String update]) progress(String message) {
    _stopwatch
      ..reset()
      ..start();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 80), (t) {
      _index++;
      final char = _progressAnimation[_index % _progressAnimation.length];
      stdout.write(
        '''${Logger.green('\b${'\b' * (message.length + 4)}$char')} $message...''',
      );
    });
    return ([String? update]) {
      _stopwatch.stop();
      final time = (_stopwatch.elapsed.inMilliseconds / 1000.0).toStringAsFixed(1);
      stdout.write(
        '''${Logger.green('\b${'\b' * (message.length + 4)}✓')} ${update ?? message} (${time}ms)\n''',
      );
      _timer?.cancel();
    };
  }
}
