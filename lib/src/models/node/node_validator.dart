class NodeValidator {
  NodeValidator({
    required this.key,
    this.isRequired = true,
    this.validValues = const [],
  });

  final String key;
  final bool isRequired;
  final List<dynamic> validValues;
  String reason = '';

  void validateValue(dynamic value) {
    reason = validValues.isEmpty || validValues.contains(value)
        ? ""
        : "valid values are: $validValues but received: $value";
  }

  bool get isValid => reason.isEmpty;
}
