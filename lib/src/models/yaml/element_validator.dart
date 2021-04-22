class ElementValidator {
  ElementValidator({
    required this.key,
    required this.isRequired,
    required this.validValues,
  });

  final String key;
  final bool isRequired;
  final List<dynamic> validValues;
  String reason = '';

  void setValidator(dynamic? value) {
    if (isRequired && value == null) {
      reason = '$key is required';
    } else if (value != null && _hasValidValues(value)) {
      reason = 'value isn\'t valid: $validValues';
    }
  }

  bool _hasValidValues(dynamic value) =>
      validValues.isNotEmpty && !validValues.contains(value);

  bool get isValid => reason.isEmpty;
}
