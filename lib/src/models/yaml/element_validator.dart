class ElementValidator {
  ElementValidator({
    required this.key,
    this.isRequired = true,
    this.validValues = const [],
  });

  final String key;
  final bool isRequired;
  final List<dynamic> validValues;
  String reason = '';

  void setValidator(dynamic? value) {
    if (isRequired && value == null) {
      reason = '$key is required';
    } else if (value != null && _hasValidValues(value)) {
      validValues.removeWhere((e) => e.isEmpty);
      reason = "value isn't valid: $validValues";
    }
  }

  bool _hasValidValues(dynamic value) =>
      validValues.isNotEmpty && !validValues.contains(value);

  bool get isValid => reason.isEmpty;
}
