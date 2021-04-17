class FormatException implements Exception {
  const FormatException(this.message);

  /// A message describing the format error.
  final String message;

  @override
  String toString() => '$message\n';
}
