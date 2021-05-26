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

  @override
  String toString() {
    return 'NodeValidator{key: $key, isRequired: $isRequired, validValues: $validValues, reason: $reason}';
  }

  MapEntry<String, String> toReasonMapEntry() => MapEntry(key, reason);
}
