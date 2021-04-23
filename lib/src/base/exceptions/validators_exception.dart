class ValidatorsException implements Exception {
  const ValidatorsException({this.message = ''});

  /// A message describing the format error.
  final String message;

  @override
  String toString() => '';
}
