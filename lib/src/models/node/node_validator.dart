class NodeValidator {
  NodeValidator({
    required this.key,
    this.isRequired = true,
    validValues = const [],
  }) : validValues = isRequired
            ? validValues
            : validValues.isEmpty
                ? []
                : [...validValues, null];

  final String key;
  final bool isRequired;
  final List<dynamic> validValues;
  String _reason = '';

  String get reason => _reason;

  void validateValue(dynamic? value) {
    if (isRequired && value == null) {
      _reason = '$key is required';
      return;
    }

    if (validValues.isNotEmpty && !validValues.contains(value)) {
      _reason = "valid values are: $validValues but received: $value";
    }
  }

  bool get isValid => _reason.isEmpty;

  MapEntry<String, String> get mapEntry => MapEntry(key, _reason);
}
