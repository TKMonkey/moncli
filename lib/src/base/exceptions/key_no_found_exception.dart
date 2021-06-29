class KeyNotFoundException implements Exception {
  const KeyNotFoundException(this.key, {this.fileName = 'pubspec.yaml'});

  /// A message describing the format error.
  final String key;
  final String? fileName;

  @override
  String toString() => 'Please, add param $key in your $fileName\n';
}
